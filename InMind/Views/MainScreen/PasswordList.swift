import SwiftUI

struct PasswordList: View {
    @StateObject var coreDataModel:CoreData
    
    var body: some View {
        VStack(spacing: 0){
            Text("Passwords")
                .padding(.vertical, 10)
                .font(.system(.title, design: .rounded, weight: .bold))
                .foregroundStyle(Color("SideColor"))
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(coreDataModel.passwords) { password in
                        VStack(alignment: .leading, spacing: 10) {
                            usernamePasswordSection(passwordData: password.name ?? "NaN", text: "Username:")
                            usernamePasswordSection(passwordData: password.password ?? "NaN", text: "Password:")
                            commentSection(passwordData: password.comment ?? "NaN", text: "Note")
                            
                            PasswordCellButtonsView(coreData: coreDataModel, password: password)
                                .padding(.horizontal, 10)
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
                .fontWeight(.regular)
                .foregroundStyle(Color("MainColor"))
            Text(passwordData)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(Color("MainColor"))
                .minimumScaleFactor(0.5)
           
        }
    }
    
    func commentSection(passwordData: String, text:LocalizedStringKey) -> some View {
        VStack(alignment:.leading, spacing: 5){
            Text(text)
                .padding(.bottom, 5)
                .font(.caption)
                .fontWeight(.regular)
                //.underline(true, color: Color("MainColor"))
                .foregroundStyle(Color("MainColor"))
            Rectangle()
                .fill(Color("MainColor"))
                .frame(maxWidth: .infinity)
                .frame(height:1)
            Text(passwordData)
                .font(.caption)
                .fontWeight(.medium)
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

  
}

struct PasswordList_Previews: PreviewProvider {
    static var previews: some View {
        PasswordList(coreDataModel: CoreData())
    }
}
