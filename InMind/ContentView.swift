import SwiftUI

struct ContentView: View {
    @StateObject private var coredataModel = CoreData()
    
    var body: some View {
        if coredataModel.isLoadingCompleted {
            SplashScreen(cdModel:coredataModel) }
        
        else {
            MainScreen(coreDataModel: coredataModel) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
