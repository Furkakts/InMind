import SwiftUI

struct OnboardingView: View {
    @State private var pageNumberInOnboardingView = 1
    
      // Takes data from file and fills title and text arrays below
    private let pageTitle:[LocalizedStringKey] = TextForOnboardingPage.titleOfPage
    private var titleForEachOnboardingPage:LocalizedStringKey {
        pageTitle[pageNumberInOnboardingView-1]
    }
    
    private let pageText:[LocalizedStringKey] = TextForOnboardingPage.textOfPage
    private var textForEachOnboardingPage:LocalizedStringKey {
        pageText[pageNumberInOnboardingView-1]
    }
    
    var body: some View {
        
        switch pageNumberInOnboardingView {  // Visit over onboarding view pages
           case 1:
              OnboardingPage(pageNumber: $pageNumberInOnboardingView, title: titleForEachOnboardingPage, text: textForEachOnboardingPage, numberOfPages: pageText.count)
           case 2:
              OnboardingPage(pageNumber: $pageNumberInOnboardingView, title: titleForEachOnboardingPage, text: textForEachOnboardingPage, numberOfPages: pageText.count)
           case 3:
              OnboardingPage(pageNumber: $pageNumberInOnboardingView, title: titleForEachOnboardingPage, text: textForEachOnboardingPage, numberOfPages: pageText.count)
           case 4:
              OnboardingPage(pageNumber: $pageNumberInOnboardingView, title: titleForEachOnboardingPage, text: textForEachOnboardingPage, numberOfPages: pageText.count)
           default:
              EmptyView()
        }
    }
}
    
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
