import SwiftUI

struct AddPasswordView: View {
    var coreDataModel:CoreData
    @State private var username = ""
    @State private var password = ""
    @State private var comment = ""
    @State private var alertMessage: LocalizedStringKey = ""
    @State private var isErrorOccurred = false
    @State private var isLoadingActivated = false
    @State private var isSaved = false
    @FocusState private var isFocused
    
    var body: some View {
        ZStack {
            Color("MainColor").ignoresSafeArea()
            
            VStack(spacing: 15){
                appName
                    .padding(.bottom, 20)
                
                Text(alertMessage)
                    .font(.system(.caption, design: .rounded, weight: .regular))
                    .foregroundStyle(isErrorOccurred ? .red : .green)
                
                textField(fieldText: $username, text:"E-mail / Username")
                textField(fieldText: $password, text: LocalizedStringResource("Password", table: "Extra"))
                textEditor(editorText: $comment, text: "Comment")
                
                HStack(spacing: 30){
                    resetButton
                    saveButton
                }
                .padding(.top, 10)
            }
            .padding(.horizontal, 30)
            .background{
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color("SideColor"))
                    .frame(width:UIScreen.main.bounds.width-20, height: 500)
            }
        }
    }
    
    var appName: some View {
        Text("InMind")
            .font(.system(.title, design: .rounded, weight: .bold))
            .foregroundStyle(Color("MainColor"))
    }
    
    func textField(fieldText: Binding<String>, text: LocalizedStringResource) -> some View {
        VStack {
            Text(text)
                .font(.system(.subheadline, design: .rounded, weight: .medium))
                .foregroundStyle(Color("MainColor"))
                
            TextField("", text: fieldText, prompt: prompt(text: text))
                .padding(.vertical, 5)
                .foregroundStyle(Color("SideColor"))
                .background(Color("MainColor"))
                .cornerRadius(2)
                .multilineTextAlignment(.center)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            Divider()
                .frame(width:200)
                .background(Color("MainColor"))
                .padding(.top, 5)
        }
    }
    
    func prompt(text:LocalizedStringResource) -> Text {
        Text(text)
            .font(.system(.caption, design: .rounded, weight: .regular))
            .foregroundColor(Color("SideColor")
            .opacity(0.7))
    }
    
    func textEditor(editorText:Binding<String>, text:LocalizedStringResource) -> some View {
        VStack(alignment:.center){
            Text(text)
                .font(.system(.subheadline, design: .rounded, weight: .medium))
                .foregroundStyle(Color("MainColor"))
            
            TextEditor(text: editorText)
                .frame(height: 65)
                .scrollContentBackground(.hidden)
                .focused($isFocused)
                .foregroundStyle(Color("SideColor"))
                .background(Color("MainColor"))
                .cornerRadius(2)
                .multilineTextAlignment(.leading)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .overlay {
                    if comment.isEmpty { commentPlaceholder }
                }
        }
    }
    
    var commentPlaceholder: some View {
        Text("Write notes here!")
            .font(.system(.caption, design: .rounded, weight: .regular))
            .foregroundStyle(Color("SideColor"))
            .opacity(0.7)
    }
    
    var resetButton: some View {
        Button {
            reset()
        } label: {
            buttonText(text: "Reset")
        }
    }
    
    func reset(){
        username = ""
        password = ""
        comment = ""
    }
    
    var saveButton: some View {
        Button {
            isLoadingActivated = true
            
            if isFieldEmpty(username: username, password: password) || checkAvailability(username:username) {
                isLoadingActivated = false
                isErrorOccurred = true
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
                if !isLoadingActivated {
                    ProgressView()
                        .controlSize(.large)
                        .tint(Color("SideColor"))
                }
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
   
    func buttonText(text:LocalizedStringKey) -> some View {
        Text(text)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .foregroundStyle(Color("SideColor"))
            .background(Color("MainColor"), in: Capsule())
    }
    
    func isFieldEmpty(username:String, password:String) -> Bool{
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
