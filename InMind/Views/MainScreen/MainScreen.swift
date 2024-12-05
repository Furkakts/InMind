import SwiftUI

struct MainScreen: View {
    @State var cdm: CoreData
    @AppStorage("isNewUser") private var isNewUser = true
    
    var body: some View {
        TabView {
            setTabView()
                .tabItem {
                    Label("Password List", systemImage: "list.bullet.rectangle.portrait.fill")
                }

            AddPasswordView(cdm: cdm)
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
            if cdm.passwords.isEmpty { ContentUnavailableView() }
            else { PasswordList(cdm: cdm) }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("MainColor"))
    }
}

#Preview {
    MainScreen(cdm: CoreData())
}

