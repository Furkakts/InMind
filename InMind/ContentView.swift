import SwiftUI

struct ContentView: View {
    @AppStorage("isShown") private var isOnboardingShown = false
    
    var body: some View {
        ZStack(alignment:.bottom){
            Color("MainColor").ignoresSafeArea()
            
            if !isOnboardingShown {
                OnboardingView(onBoardingIsShown: $isOnboardingShown)
            } else {
                Button("Change"){
                    isOnboardingShown.toggle()
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
