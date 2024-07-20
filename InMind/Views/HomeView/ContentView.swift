import SwiftUI

struct ContentView: View {
    @AppStorage("isShown") private var isOnboardingShown = false
    @StateObject private var coredataModel = CoreData()
    
    var body: some View {
        ZStack{
            Color("MainColor").ignoresSafeArea()
            
            if !coredataModel.isLoadingCompleted {
                SplashScreen(cdModel:coredataModel)
            } else {
                if !isOnboardingShown {
                    OnboardingView(onBoardingIsShown: $isOnboardingShown)
                } else {
                    Button("Change") {
                        isOnboardingShown.toggle()
                    }
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
