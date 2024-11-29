import SwiftUI

struct SplashScreen: View {
    @State var cdModel: CoreData
    
    var body: some View {
        VStack{
            Text("InMind")
                .padding(.top, 150)
                .font(.system(size: 50, weight:.semibold, design: .rounded))
                .foregroundStyle(Color("SideColor"))
            Spacer()
            VStack(spacing: 50) {
                DataProgressView(dataModel: cdModel)
                VersionView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("MainColor"))
        .onAppear { cdModel.setContainer() }
    }
}
 
#Preview {
    SplashScreen(cdModel: CoreData())
}
