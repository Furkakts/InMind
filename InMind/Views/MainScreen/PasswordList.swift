import SwiftUI

struct PasswordList: View {
    @StateObject var coreDataModel:CoreData
    
    var body: some View {
        VStack(spacing: 0){
            Text("Passwords")
                .padding(.vertical, 20)
                .font(.system(.title, design: .rounded, weight: .bold))
                .foregroundStyle(Color("SideColor"))
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(coreDataModel.passwords) { password in
                        VStack(alignment: .leading, spacing: 10) {
                            usernamePasswordSection(passwordData: password.name ?? "NaN", text: "Username:")
                            usernamePasswordSection(passwordData: password.password ?? "NaN", text: "Password:")
                            commentSection(passwordData: password.comment ?? "NaN", text: "Comment")
                            
                            HStack{
                                Spacer()
                                Button {
                                    coreDataModel.deletePassword(deletedPassword: password)
                                }label: {
                                    Text("DELETE")
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 8)
                                        .font(.system(.subheadline, design: .rounded, weight: .medium))
                                        .foregroundStyle(Color("SideColor"))
                                        .background(Color("MainColor"), in: Capsule())
                                } .padding(.trailing, 20)
                            }
                        }
                        .padding()
                        .background(Color("SideColor"))
                        .cornerRadius(30)
                        .shadow(radius: 2, y:5)
                    }
                }
            }.padding(.horizontal, 5)
        }
    }
    
    func usernamePasswordSection(passwordData: String, text:LocalizedStringKey) -> some View {
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
                .padding(.leading, 10)
                .foregroundStyle(Color("MainColor"))
                .onTapGesture {
                    copy(copiedText:passwordData)
                }
        }
    }
    
    func commentSection(passwordData: String, text:LocalizedStringKey) -> some View {
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
