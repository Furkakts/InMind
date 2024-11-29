//  Created by Furkan Aktaş on 30.11.2024.
import SwiftUI

struct VersionView: View {
    
    var body: some View {
        Text("\(Bundle.main.appVersionLong).\(Bundle.main.appBuild)")
            .font(.system(.callout, design: .rounded, weight: .medium))
            .foregroundStyle(Color("SideColor"))
            .kerning(1.7)
    }
}

// Gets application's version and build
extension Bundle {
    public var appBuild: String {
        getInfo("CFBundleVersion")
    }
    public var appVersionLong: String {
        getInfo("CFBundleShortVersionString")
    }
    
    fileprivate func getInfo(_ str: String) -> String {
        infoDictionary?[str] as? String ?? "?"
    }
}

#Preview {
    VersionView()
}
