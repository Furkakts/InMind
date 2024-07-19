import SwiftUI

struct OnboardingView: View {
    
    @Binding var onBoardingIsShown:Bool
    @State private var pageNumberInOnboardingView = 1
    
    private let pageTitle:[String] = TextForOnboardingPage.titleOfPage
    private var titleForEachOnboardingPage:String {
        pageTitle[pageNumberInOnboardingView-1]
    }
    
    private let pageText:[String] = TextForOnboardingPage.textOfPage
    private var textForEachOnboardingPage:String {
        pageText[pageNumberInOnboardingView-1]
    }
    var body: some View {
        switch pageNumberInOnboardingView {  // Visit over onboarding pages
           case 1:
              OnboardingPage(pageNumber: $pageNumberInOnboardingView, isShown: $onBoardingIsShown,
                            title: titleForEachOnboardingPage, text: textForEachOnboardingPage, numberOfPages: pageText.count)
           case 2:
              OnboardingPage(pageNumber: $pageNumberInOnboardingView, isShown: $onBoardingIsShown,
                            title: titleForEachOnboardingPage, text: textForEachOnboardingPage, numberOfPages: pageText.count)
           case 3:
              OnboardingPage(pageNumber: $pageNumberInOnboardingView, isShown: $onBoardingIsShown,
                            title: titleForEachOnboardingPage, text: textForEachOnboardingPage, numberOfPages: pageText.count)
           case 4:
              OnboardingPage(pageNumber: $pageNumberInOnboardingView, isShown: $onBoardingIsShown,
                            title: titleForEachOnboardingPage, text: textForEachOnboardingPage, numberOfPages: pageText.count)
           default:
              Text("")
        }
    }
}
//    
//struct OnboardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingView(onBoardingIsShown: <#Binding<Bool>#>)
//    }
//}
