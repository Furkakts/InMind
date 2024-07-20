import SwiftUI

struct ContentView: View {
    @AppStorage("isShown") private var isOnboardingShown = false
    private var isCoreDataLoaded = false
    
    var body: some View {
        ZStack{
            Color("MainColor").ignoresSafeArea()
            
            if !isCoreDataLoaded {
                SplashScreen()
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
