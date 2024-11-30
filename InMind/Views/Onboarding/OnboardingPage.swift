import SwiftUI

struct OnboardingPage: View {
    @AppStorage("isNewUser") private var isNewUser = true
    let page:Int
    
    var body:some View {
        VStack(spacing: 20){
            Text(OnboardingContent.titles[page])
                .font(.system(.title3, design: .rounded, weight: .bold))
                .foregroundStyle(Color("MainColor"))
                .minimumScaleFactor(0.5)
                
            Text(OnboardingContent.descriptions[page])
                .font(.system(.subheadline, design: .rounded, weight: .medium))
                .foregroundStyle(Color("MainColor"))
                .lineSpacing(4)
                .kerning(0.8)
                .multilineTextAlignment(.center)
            
            if page == OnboardingContent.titles.count-1 { button }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("SideColor"))
    } // End body
    
    // Button to close Onboarding View.
    var button: some View {
        Button {
            isNewUser.toggle()
        }label: {
            Text("FINISH")
                .padding(.horizontal, 50)
                .padding(.vertical, 10)
                .font(.system(.callout, design: .rounded, weight: .bold))
                .foregroundStyle(Color("SideColor"))
                .background(Color("MainColor"), in: Capsule(style: .continuous))
        }
    }
}

#Preview {
    OnboardingPage(page: 0)
}
