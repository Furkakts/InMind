//  Created by Furkan Aktaş on 4.12.2024.
import SwiftUI

struct PasswordCellButtonsView: View {
    @State var coreData:CoreData
    var password: PasswordEntity
    
    var body: some View {
        HStack {
            Button { UIPasteboard.general.string = password.password ?? "" }
            label: { setLabelImage(labelName: "Copy Password", imageName: "key.fill") }
            
            Spacer()
            
            Button { coreData.deletePassword(deletedPassword: password) }
            label: { setLabelImage(labelName: "Delete", imageName: "trash.fill") }
        }
    }
    
    func setLabelImage(labelName: LocalizedStringKey, imageName: String) -> some View {
        Label(labelName, systemImage: imageName)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .font(.system(.caption, design: .rounded, weight: .medium))
            .foregroundStyle(Color("SideColor"))
            .background(Color("MainColor"), in: Capsule())
    }
}

#Preview {
    PasswordCellButtonsView(coreData: CoreData(), password: PasswordEntity())
}
