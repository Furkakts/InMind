import SwiftUI

struct SplashScreen: View {
    private let appName = "InMind"
    @StateObject var cdModel:CoreData
    
    var body: some View {
        VStack{
            Text(appName)
                .padding(.top, 150)
                .font(.system(size: 50, weight:.semibold, design: .rounded))
                .foregroundStyle(Color("SecondaryColor"))
            Spacer()
            bottomSection
                .padding(.horizontal)
        }
        .onAppear{
            cdModel.setContainer()
        }
    }
    
    // Shows Version and Loading Sign or Error Text based on case while loading data from local database.
    var bottomSection: some View {
        VStack(spacing:50){
            if cdModel.isErrorOccurred {
                Text("Unknown error occurred.Please Try again!")
                    .padding()
                    .font(.subheadline)
                    .frame(maxWidth:.infinity)
                    .frame(height:25)
                    .foregroundStyle(Color("MainColor"))
                    .background(Color("SecondaryColor"), in:RoundedRectangle(cornerRadius: 3))
            } else {
                ProgressView()
                    .font(.title)
                    .controlSize(.regular)
                    .tint(Color("SecondaryColor"))
            }
                
            Text("\(Bundle.main.appVersionLong).\(Bundle.main.appBuild)")
               .font(.footnote)
               .fontWeight(.semibold)
               .foregroundStyle(Color("SecondaryColor"))
        }
    }
}
  // Gets application's version and build
extension Bundle {
    public var appBuild: String          { getInfo("CFBundleVersion") }
    public var appVersionLong: String    { getInfo("CFBundleShortVersionString") }
    
    fileprivate func getInfo(_ str: String) -> String { infoDictionary?[str] as? String ?? "?"}
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(cdModel: CoreData())
    }
}
