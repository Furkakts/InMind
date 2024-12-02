//  Created by Furkan Aktaş on 3.12.2024.
import SwiftUI

struct ContentUnavailableView: View {
    private let message = "There is nothing to show now. You can see your passwords and related information here if you add password."
    
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
        .padding()
        .frame(width: 300, height: 300)
    }
}

#Preview {
    ContentUnavailableView()
}
