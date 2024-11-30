//  Created by Furkan Aktaş on 30.11.2024.
import SwiftUI

struct DataProgressView: View {
    @State var dataModel: CoreData
    
    var body: some View {
        if dataModel.isErrorOccurred {
            errorView }
        else {
            ProgressView()
                .controlSize(.regular)
                .tint(Color("SideColor"))
        }
    }
    
    var errorView: some View {
        Text("Error occurred. Try again!")
            .frame(maxWidth: .infinity)
            .frame(height: 30)
            .font(.system(.subheadline, design: .rounded, weight: .medium))
            .foregroundStyle(Color("MainColor"))
            .background(Color("SideColor"), in:RoundedRectangle(cornerRadius: 3))
    }
}

#Preview {
    DataProgressView(dataModel: CoreData())
}
