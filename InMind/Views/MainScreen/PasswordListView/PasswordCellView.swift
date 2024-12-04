//  Created by Furkan Aktaş on 4.12.2024.
import SwiftUI

struct PasswordCellView: View {
    var password: PasswordEntity
    
    var body: some View {
        NecessaryFieldsView(fieldName: "Username:", fieldData: password.name ?? "")
        NecessaryFieldsView(fieldName: "Password:", fieldData: password.password ?? "")
        NoteView(fieldName: "Note", fieldData: password.comment ?? "")
            .padding(.horizontal, 20)
            .frame(maxWidth:.infinity)
    }
}

struct NecessaryFieldsView: View {
    let fieldName: LocalizedStringKey
    let fieldData: String
    
    var body: some View {
        HStack(spacing: 5) {
            Text(fieldName)
                .padding(.leading, 20)
                .font(.system(.caption, design: .rounded, weight: .regular))
                .foregroundStyle(Color("MainColor"))
            Text(fieldData)
                .font(.system(.subheadline, design: .rounded, weight: .medium))
                .foregroundStyle(Color("MainColor"))
                .minimumScaleFactor(0.5)
        }
    }
}

struct NoteView: View {
    let fieldName: LocalizedStringKey
    let fieldData: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(fieldName)
                .font(.system(.caption, design: .rounded, weight: .regular))
                .foregroundStyle(Color("MainColor"))
            Rectangle()
                .fill(Color("MainColor"))
                .frame(maxWidth: .infinity)
                .frame(height:1)
            Text(fieldData)
                .font(.system(.caption, design: .rounded, weight: .medium))
                .foregroundStyle(Color("MainColor"))
                .minimumScaleFactor(0.5)
        }
    }
}



#Preview {
    PasswordCellView(password: PasswordEntity())
}
