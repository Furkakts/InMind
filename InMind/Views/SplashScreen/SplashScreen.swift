import SwiftUI

struct SplashScreen: View {
    @State var cdm: CoreData
    
    var body: some View {
        VStack{
            Text("InMind")
                .padding(.top, 150)
                .font(.system(size: 50, weight:.semibold, design: .rounded))
                .foregroundStyle(Color("SideColor"))
            Spacer()
            VStack(spacing: 50) {
                DataProgressView(cdm: cdm)
                VersionView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("MainColor"))
        .onAppear { cdm.setContainer() }
    }
}
 
#Preview {
    SplashScreen(cdm: CoreData())
}
