import SwiftUI

struct SplashScreen: View {
    private let appName = "InMind"
    var body: some View {
        VStack{
            Text(appName)
                .padding(.top, 150)
                .font(.system(size: 50, weight:.semibold, design: .rounded))
                .foregroundStyle(Color("SecondaryColor"))
            Spacer()
            VStack(spacing:50){
                ProgressView()
                    .font(.title)
                    .controlSize(.regular)
                    .tint(Color("SecondaryColor"))
                    
                Text("\(Bundle.main.appVersionLong).\(Bundle.main.appBuild)")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("SecondaryColor"))
            }
        }
    }
}

extension Bundle {
    public var appBuild: String          { getInfo("CFBundleVersion") }
    public var appVersionLong: String    { getInfo("CFBundleShortVersionString") }
    
    fileprivate func getInfo(_ str: String) -> String { infoDictionary?[str] as? String ?? "" }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
