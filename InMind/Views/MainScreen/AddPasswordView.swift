import SwiftUI

struct AddPasswordView: View {
    // MARK: Properties
    var coreDataModel:CoreData
    @State private var username = ""
    @State private var password = ""
    @State private var comment = ""
    @State private var confirmationMessage: LocalizedStringKey = ""
    @State private var isErrorOccurred = false
    @State private var isSaved = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color("MainColor").ignoresSafeArea()
            
            VStack(spacing: 15){
                appName
                Text(confirmationMessage)
                    .font(.system(.caption, design: .rounded, weight: .medium))
                    .foregroundStyle(isErrorOccurred || !isSaved ? .red : .green)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                
                textField(fieldText: $username, text:"Account Name")
                textField(fieldText: $password, text: LocalizedStringResource("Password", table: "Extra"))
                textEditor(editorText: $comment, text: "Note")
                
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
    // MARK: Views
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
                .padding(.vertical, 8)
                .foregroundStyle(Color("SideColor"))
                .background(Color("MainColor"))
                .cornerRadius(2)
                .multilineTextAlignment(.center)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .tint(Color("SideColor"))
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
        VStack(alignment:.center, spacing: 5){
            HStack {
                Text(text)
                    .font(.system(.subheadline, design: .rounded, weight: .medium))
                    .foregroundStyle(Color("MainColor"))
                Spacer()
                clearButton
            }
            .padding(.leading, 20)
            
            TextEditor(text: editorText)
                .frame(height: 65)
                .scrollContentBackground(.hidden)
                .foregroundStyle(Color("SideColor"))
                .background(Color("MainColor"))
                .cornerRadius(2)
                .multilineTextAlignment(.leading)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .tint(Color("SideColor"))
        }
    }
    
    var clearButton: some View {
        Label("Clear", systemImage: "arrowshape.down.fill")
            .focused($isFocused)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .font(.system(.caption, design: .rounded, weight: .medium))
            .foregroundStyle(Color("SideColor"))
            .background(Color("MainColor"), in: Capsule())
            .onTapGesture {
                comment = ""
                isFocused = false
            }
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
    
    func buttonText(text:LocalizedStringKey) -> some View {
        Text(text)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .foregroundStyle(Color("SideColor"))
            .background(Color("MainColor"), in: Capsule())
    }
    // MARK: Functions
    var saveButton: some View {
        Button {
            if isFieldEmpty() || isAvailable() {
                setWarning() }
            else {
                save() }
        }label: { buttonText(text: "Save") }
    }
   
    func isFieldEmpty() -> Bool{
        if username.isEmpty || password.isEmpty {
            confirmationMessage = "You can't leave username or password empty. Please fill them."
            return true
        }
        return false
    }
    
    func isAvailable() -> Bool{
        let result = coreDataModel.passwords.map { password in password.name }.contains(username)
        if result {
            confirmationMessage = "Username/E-mail is already in your list."
            return true
       }
        return false
    }
    
    func setWarning() {
        isErrorOccurred = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isErrorOccurred = false
            confirmationMessage = ""
        }
    }
    
    func save() {
        var defaultComment = ""
        
        if comment.isEmpty { defaultComment = "There is no note." }
        else { defaultComment = comment.trimmingCharacters(in: .whitespacesAndNewlines) }
        
        coreDataModel.addPassword(username:username, password:password, comment: defaultComment)
        
        confirmationMessage = "Saved Successfully."
        isSaved = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            isSaved = false
            confirmationMessage = ""
            isFocused = false
            reset()
        }
    }
}

struct AddPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        AddPasswordView(coreDataModel: CoreData())
    }
}
