

import SwiftUI

struct AddPasswordView: View {
    var coreDataModel:CoreData
    @State private var username = ""
    @State private var password = ""
    @State private var comment = ""
    @State private var alertMessage: LocalizedStringKey = ""
    @State private var isSameEntryGiven = false
    @State private var isLoadingActivated = false
    @State private var isSaved = false
    @FocusState private var isFocused
    
    var body: some View {
        ZStack {
            Color("MainColor").ignoresSafeArea()
            
            VStack(spacing: 20){
                appName
                
                textField(fieldText: $username, text:"E-mail / Username")
                textField(fieldText: $password, text: LocalizedStringResource("Password", table: "Extra"))
                textEditor(editorText: $comment, text: "Comment")
                
                HStack(spacing:50){
                    resetButton
                    saveButton
                } .padding(.top, 30)
            }  // End VStack
            .padding()
            .padding(.horizontal, 30)
            .background{
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("SideColor"))
                    .frame(width:UIScreen.main.bounds.width-20, height: 650)
            }
            .alert(alertMessage, isPresented: $isSameEntryGiven) {
                Button("OK", role:.cancel){
                    isSameEntryGiven.toggle()
                    reset()
                }
            }
        } // End ZStack
    }
    
    func textField(fieldText: Binding<String>, text: LocalizedStringResource) -> some View {
        return Group {
            VStack {
                formText(text: text)
                TextField("", text: fieldText, prompt: prompt(text: text))
                    .padding(.vertical, 10)
                    .foregroundStyle(Color("SideColor"))
                    .background(Color("MainColor"))
                    .cornerRadius(5)
                    .multilineTextAlignment(.center)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }
            divider
        }
    }
    
    func textEditor(editorText:Binding<String>, text:LocalizedStringResource) -> some View {
        VStack(alignment:.center){
            formText(text:text)
            TextEditor(text: editorText)
                .frame(height:100)
                .scrollContentBackground(.hidden)
                .focused($isFocused)
                .foregroundStyle(Color("SideColor"))
                .background(Color("MainColor"), in: RoundedRectangle(cornerRadius: 5, style: .continuous))
                .multilineTextAlignment(.leading)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .overlay {
                    if comment.isEmpty {
                        commentPlaceholder
                    }
                }
        }
    }
    
    var commentPlaceholder: some View {
        HStack{
            Text("Write comments here!")
                .font(.headline)
                .fontWeight(.light)
                .foregroundStyle(Color("SideColor"))
                .opacity(0.9)
        }
    }
    
    var appName: some View {
        Text("InMind")
            .padding(.bottom, 20)
            .font(.title)
            .bold()
            .foregroundStyle(Color("MainColor"))
    }
    
    var divider: some View {
        Divider()
            .frame(width:200)
            .background(Color("MainColor"))
    }
    
    var resetButton: some View {
        Button {
            reset()
        } label: {
            buttonText(text: "Reset")
        }
    }
    
    var saveButton: some View {
        Button {
            isLoadingActivated = true
            
            if checkEmptyness(username: username, password: password) || checkAvailability(username:username) {
                isLoadingActivated = false
                isSameEntryGiven = true
            } else {
                if comment.isEmpty { comment = "NaN" }
                let indentedComment = "         " + comment
                coreDataModel.addPassword(username:username, password:password, comment: indentedComment)
                
                isLoadingActivated = false
                isSaved = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75){
                    isSaved = false
                    isFocused = false
                    reset()
                }
             
            }
        } label: {
            ZStack{
                buttonText(text: "Save")
                if isLoadingActivated {
                    progressView }
                if isSaved {
                    Text("Saved")
                        .padding(10)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(Color("MainColor"))
                        .background(Color("SideColor"), in: RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .overlay(alignment:.topTrailing){
           
        }
    }
    
    var progressView: some View {
        ProgressView()
            .font(.title)
            .controlSize(.large)
            .tint(Color("SideColor"))
    }
    
    func prompt(text:LocalizedStringResource) -> Text {
        Text(text)
            .foregroundColor(Color("SideColor").opacity(0.7))
    }
    
    func formText(text:LocalizedStringResource) -> some View {
        Text(text)
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundStyle(Color("MainColor"))
    }
    
    func buttonText(text:LocalizedStringKey) -> some View {
        Text(text)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .foregroundStyle(Color("SideColor"))
            .background(Color("MainColor"), in: RoundedRectangle(cornerRadius: 8))
    }
    
    func reset(){
        username = ""
        password = ""
        comment = ""
    }
    
    func checkEmptyness(username:String, password:String) -> Bool{
        if username.isEmpty || password.isEmpty {
            alertMessage = "You can't leave fields empty.Please fill them."
            return true
        }
        return false
    }
    
    func checkAvailability(username:String) -> Bool{
        let result = coreDataModel.passwords.map { password in password.name }.contains(username)
        if result {
            alertMessage = "Entry for username or e-mail is invalid or already in your list.Please Try again!"
             return true
       }
        return false
    }
}

struct AddPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        AddPasswordView(coreDataModel: CoreData())
    }
}
