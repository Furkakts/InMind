//  Created by Furkan Aktaş on 3.12.2024.
import SwiftUI

struct SaveView: View {
    @Binding var username: String
    @Binding var password: String
    @Binding var comment: String
    
    var body: some View {
        HStack(spacing: 40){
            resetButton
            saveButton
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
}

#Preview {
    SaveView()
}
