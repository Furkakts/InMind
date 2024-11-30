import SwiftUI

struct OnboardingView: View {
    private let onboardingPage: Int = OnboardingContent.titles.count
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor
                         = UIColor(named: "MainColor")
        UIPageControl.appearance().pageIndicatorTintColor
                         = UIColor(named: "MainColor")?.withAlphaComponent(0.4)
    }
    
    var body: some View {
        TabView {
            ForEach(0..<onboardingPage, id:\.self){ page in
                OnboardingPage(page: page)
            }
        }
        .tabViewStyle(.page)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .background(Color("SideColor"))
    } 
}
    
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
