import SwiftUI

struct PasswordList: View {
    @StateObject var coreDataModel:CoreData
    
    var body: some View {
        VStack(alignment:.leading, spacing: 10){
            Text("Passwords")
                .padding(.leading, 40)
                .padding(.vertical, 10)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color("SideColor"))
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(coreDataModel.passwords) { password in
                    VStack(spacing: 20) {
                        HStack{
                            VStack(alignment:.leading, spacing: 10){
                                usernamePasswordSection(passwordData: password.name ?? "NaN", text: "Username:")
                                usernamePasswordSection(passwordData: password.password ?? "NaN", text: "Password:")
                            }
                            Spacer()
                            Button {
                                    coreDataModel.deletePassword(deletedPassword: password)
                            } label: {
                                 deleteButton
                            } .padding(.trailing, 35)
                        }
                        commentSection(passwordData: password.comment ?? "NaN", text: "Comment")
                    }
                    .padding(.vertical, 20)
                    .background(Color("SideColor"), in: RoundedRectangle(cornerRadius: 5))
                }
            }
            .padding(5)
        }
    }
    
    var deleteButton: some View {
        Image(systemName:"trash.circle")
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundStyle(Color("MainColor"))
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
