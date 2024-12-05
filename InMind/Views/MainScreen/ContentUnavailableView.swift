//  Created by Furkan Aktaş on 3.12.2024.
import SwiftUI

struct ContentUnavailableView: View {
    private let message: LocalizedStringKey = "There is nothing to show now. You can view your passwords here when you add a new password."
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "note.text.badge.plus")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundStyle(Color("SideColor"))
            
            Text(message)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(Color("SideColor"))
                .kerning(1.0)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 50)
    }
}

#Preview {
    ContentUnavailableView()
}
