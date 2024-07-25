

import SwiftUI

struct AddPasswordView: View {
    var coreDataModel:CoreData
    @State private var username = ""
    @State private var password = ""
    @State private var comment = ""
    @State private var isSameEntryGiven = false
    @State private var isLoadingActivated = false
    private let alertMessage = "Username/E-mail is invalid or already in your password list.Try again with different username"
    
    var body: some View {
        ZStack {
            Color("MainColor").ignoresSafeArea()
            
            VStack(spacing: 30){
                Text("InMind")
                    .padding(.bottom, 20)
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color("MainColor"))

                HStack{
                    formText(text: "Username:")
                    TextField("E-mail or Username", text:$username)
                        .textFieldStyle(.roundedBorder)
                }
                HStack{
                    formText(text: "Password:")
                    TextField("Password", text:$password)
                        .textFieldStyle(.roundedBorder)
                }
                HStack(alignment:.top){
                    formText(text:"Comment:")
                    TextEditor(text: $comment)
                        .frame(height:100)
                }
                
                HStack(spacing:50){
                    resetButton
                    saveButton
                }
                .padding(.top, 50)
            }
            .padding()
            .background{
                RoundedRectangle(cornerRadius: 5)
                   .fill(Color("SecondaryColor"))
                   .frame(width:UIScreen.main.bounds.width-20, height: 550)
                
            }
            .alert(alertMessage, isPresented: $isSameEntryGiven) {
                Button("", role:.cancel){
                    isSameEntryGiven.toggle()
                    username = ""
                }
            }
        }
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
            
            if checkAvailability(username:username) {
                isLoadingActivated = false
                isSameEntryGiven = true
            } else {
                coreDataModel.addPassword(username:username, password:password, comment:comment)
                isLoadingActivated = false
                reset()
            }
        } label: {
            ZStack{
                buttonText(text: "Save")
                if isLoadingActivated {
                    progressView }
            }
        }
    }
    
    var progressView: some View {
        ProgressView()
            .font(.title)
            .controlSize(.large)
            .tint(Color("SecondaryColor"))
    }
    
    func formText(text:String) -> some View {
        Text(text)
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundStyle(Color("MainColor"))
    }
    
    func buttonText(text:String) -> some View {
        Text(text)
            .padding(.horizontal, 40)
            .padding(.vertical, 15)
            .foregroundStyle(Color("SecondaryColor"))
            .background(Color("MainColor"), in: RoundedRectangle(cornerRadius: 8))
    }
    
    func reset(){
        username = ""
        password = ""
        comment = ""
    }
    
    func checkAvailability(username:String) -> Bool{
        coreDataModel.passwords.map { password in password.name }.contains(username)
    }
}

struct AddPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        AddPasswordView(coreDataModel: CoreData())
    }
}
