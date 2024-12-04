import SwiftUI

struct PasswordList: View {
    @StateObject var coreDataModel:CoreData
    
    var body: some View {
        VStack(spacing: 0){
            title
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(coreDataModel.passwords) { password in
                    VStack(alignment: .leading, spacing: 10) {
                        PasswordCellView(password: password)
                        PasswordCellButtonsView(coreData: coreDataModel, password: password)
                            .padding(.horizontal, 10)
                    }
                    .padding()
                    .background(Color("SideColor"))
                    .cornerRadius(30)
                    .shadow(radius: 2, y:5)
                    .padding(.bottom, 20)
                }
            }.padding(.horizontal, 8)
        }
    }
    
    var title: some View {
        Text("Passwords")
            .padding(.vertical, 10)
            .font(.system(.title, design: .rounded, weight: .bold))
            .foregroundStyle(Color("SideColor"))
    }
}

struct PasswordList_Previews: PreviewProvider {
    static var previews: some View {
        PasswordList(coreDataModel: CoreData())
    }
}
