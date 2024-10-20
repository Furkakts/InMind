import SwiftUI

struct MainScreen: View {
    @StateObject var coreDataModel: CoreData

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
        .tint(Color("MainColor"))
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor(Color("SideColor"))
        }
    }

    func firstTabItem() -> some View {
        return ZStack {
                  Color("MainColor").ignoresSafeArea(edges: .top)
                  Group {
                      if coreDataModel.passwords.isEmpty { contentUnavailable }
                      else { PasswordList(coreDataModel: coreDataModel) }
                  }
               }
    }
    
    var contentUnavailable: some View {
        VStack(spacing: 30) {
            Image(systemName: "note.text.badge.plus")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundStyle(Color("SideColor"))

            Text("There is nothing to show now. You can see your passwords and related information here if you add password.")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(Color("SideColor"))
                .kerning(1.0)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(width: 300, height: 300)
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(coreDataModel: CoreData())
    }
}
