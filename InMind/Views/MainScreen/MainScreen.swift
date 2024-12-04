import SwiftUI

struct MainScreen: View {
    @StateObject var coreDataModel: CoreData
    @AppStorage("isNewUser") private var isNewUser = true
    
    var body: some View {
        TabView {
            setTabView()
                .tabItem {
                    Label("Password List", systemImage: "list.bullet.rectangle.portrait.fill")
                }

            AddPasswordView(coreDataModel: coreDataModel)
                .tabItem {
                    Label("Add", systemImage: "plus.app.fill")
                }
        }
        .tint(Color("MainColor"))
        .onAppear {
            UITabBar.appearance().barTintColor = UIColor(Color("SideColor"))
            UITabBar.appearance().backgroundColor = UIColor(Color("SideColor"))
        }
        .sheet(isPresented: $isNewUser){
            OnboardingView()
                .presentationDetents([.fraction(0.26)])
                .interactiveDismissDisabled()
                .presentationDragIndicator(.hidden)
        }
    }

    func setTabView() -> some View {
        Group {
            if coreDataModel.passwords.isEmpty { ContentUnavailableView() }
            else { PasswordList(coreDataModel: coreDataModel) }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("MainColor"))
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(coreDataModel: CoreData())
    }
}
