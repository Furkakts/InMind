import SwiftUI

struct ContentView: View {
    @StateObject private var coredataModel = CoreData()
    
    var body: some View {
        if !coredataModel.isLoadingCompleted {
            SplashScreen(cdm:coredataModel) }
        
        else {
            MainScreen(cdm: coredataModel) }
    }
}

#Preview {
    ContentView()
}
