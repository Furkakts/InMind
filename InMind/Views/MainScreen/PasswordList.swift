import SwiftUI

struct PasswordList: View {
    @StateObject var coreDataModel:CoreData
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(coreDataModel.passwords) { password in
                VStack(spacing: 20) {
                    HStack{
                        VStack(alignment:.leading, spacing: 10){
                            usernamePasswordSection(passwordData: password.name ?? "NaN", text: "Username:")
                            usernamePasswordSection(passwordData: password.password ?? "NaN", text: "Password:")
                        }
                        Spacer()
                        HStack(spacing: 15) {
                            Button {
                                
                            } label: {
                                button(systemImageName: "pencil.circle") }
                            
                            Button {
                                coreDataModel.deletePassword(deletedPassword: password)
                            } label: {
                                button(systemImageName: "trash.circle") }
                        }
                        .padding(.trailing, 15)
                    }
                    commentSection(passwordData: password.comment ?? "NaN", text: "Comment")
                }
                .padding(.vertical, 10)
                .background(Color("SecondaryColor"), in: RoundedRectangle(cornerRadius: 5))
            }
        }
        .padding(5)
    }
    
    func button(systemImageName:String) -> some View {
        Image(systemName:systemImageName)
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundStyle(Color("MainColor"))
    }
    
    func usernamePasswordSection(passwordData: String, text:String) -> some View {
        HStack(spacing: 5) {
            Text(text)
                .padding(.leading, 20)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color("MainColor"))
            Text(passwordData)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color("MainColor"))
                .minimumScaleFactor(0.5)
            Image(systemName: "doc.on.doc")
                .imageScale(.medium)
                .padding(.trailing, 25)
                .foregroundStyle(Color("MainColor"))
                .onTapGesture {
                    copy(copiedText:passwordData)
                }
        }
    }
    
    func commentSection(passwordData: String, text:String) -> some View {
        VStack(alignment:.leading, spacing: 5){
            Text(text)
                .padding(.bottom, 5)
                .font(.caption)
                .fontWeight(.semibold)
                //.underline(true, color: Color("MainColor"))
                .foregroundStyle(Color("MainColor"))
            Rectangle()
                .fill(Color("MainColor"))
                .frame(maxWidth: .infinity)
                .frame(height:1)
            Text(passwordData)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color("MainColor"))
                .minimumScaleFactor(0.5)
            Rectangle()
                .fill(Color("MainColor"))
                .frame(maxWidth: .infinity)
                .frame(height:1)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth:.infinity)
    }

    func copy(copiedText: String) {
        UIPasteboard.general.string = copiedText
    }
}

struct PasswordList_Previews: PreviewProvider {
    static var previews: some View {
        PasswordList(coreDataModel: CoreData())
    }
}
