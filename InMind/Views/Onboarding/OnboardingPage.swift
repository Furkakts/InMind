import SwiftUI

struct OnboardingPage: View {
    @AppStorage("isShown") private var isOnboardingShown = false
    @Binding var pageNumber:Int
    private let appName = "InMind"
    var title:String
    var text:String
    let numberOfPages:Int
    
    var body:some View {
        VStack(spacing:10){
            AppLogo(appName: appName)
            PageDescription(title: title, text: text)
            Spacer()
        
            buttonsOnPage
            Spacer()
            pageIndicator
        }
        .padding()
        .frame(width:UIScreen.main.bounds.size.width - 20, height:500)
        .background(Color("SecondaryColor"), in:RoundedRectangle(cornerRadius:5))
        .transition(.move(edge: .trailing))
    }
    
    var buttonsOnPage: some View {
        HStack(spacing:30){
            Group{   // This part decides when and how the buttons will appear according to pageNumber.
                if pageNumber != 1 {
                    Button{ withAnimation(.easeOut){pageNumber-=1} } label:{
                        Text("Back").padding(.horizontal,50)
                    }
                }
                if pageNumber != 4 {
                    Button{ withAnimation(.easeOut){pageNumber+=1} } label:{
                        Text("Next").padding(.horizontal,50)
                    }
                } else {
                    Button{ isOnboardingShown = true } label:{
                        Text("Finish").padding(.horizontal,50)
                    }
                }
            }
            .padding(.vertical,10)
            .font(.headline)
            .foregroundStyle(Color("SecondaryColor"))
            .background(Color("MainColor"), in:RoundedRectangle(cornerRadius:5))
        }
    }
    
    var pageIndicator: some View {
        HStack{
            ForEach(1..<numberOfPages+1, id:\.self){number in    // This part sets little circles to show pages at the bottom of view.
                Circle()
                    .fill(Color("MainColor"))
                    .frame(width:10, height:10)
                    .opacity(pageNumber==number ? 1.0 : 0.3)
            }
        }
    }
}

struct AppLogo:View {
    let appName:String
    
    var body: some View {
        VStack{
            Image(appName)
                .resizable()
                .scaledToFit()
                .frame(width:100, height:100)
                .cornerRadius(10)
            Text(appName)
                .font(.title2)
                .bold()
                .foregroundStyle(Color("MainColor"))
        }
        .padding(.vertical)
    }
}

struct PageDescription:View {
    var title:String
    var text:String
    
    var body: some View{
        VStack(spacing:20){
            Text(title)
                .font(.title3)
                .bold()
                .foregroundStyle(Color("MainColor"))
            Text(text)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color("MainColor"))
                .lineSpacing(3)
                .kerning(0.5)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical)
    }
}

//struct OnboardingPage_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingPage(pageNumber: <#Binding<Int>#>, isShown: <#Binding<Bool>#>, title: <#String#>, text: <#String#>, numberOfPages: <#Int#>)
//    }
//}
