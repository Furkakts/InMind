import SwiftUI

struct MainScreen: View {
    @StateObject var coreDataModel: CoreData
    @AppStorage("isNewUser") private var isNewUser = true
    var body: some View {
        TabView {
            firstTabItem()
                .tabItem {
                    Label("Password", systemImage: "list.bullet.rectangle.portrait.fill")
                }

            AddPasswordView(coreDataModel: coreDataModel)
                .tabItem {
                    Label("Add", systemImage: "plus.app.fill")
                }
        }
        .sheet(isPresented: $isNewUser){
            OnboardingView()
                .presentationDetents([.fraction(0.26)])
                .interactiveDismissDisabled()
                .presentationDragIndicator(.hidden)
        }
        .tint(Color("MainColor"))
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor(Color("SideColor"))
        }
    }

    func firstTabItem() -> some View {
        return ZStack {
                  Color("MainColor").ignoresSafeArea(edges: .top)
                  Group {
                      if coreDataModel.passwords.isEmpty { ContentUnavailableView() }
                      else { PasswordList(coreDataModel: coreDataModel) }
                  }
               }
    }
    
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(coreDataModel: CoreData())
    }
}
