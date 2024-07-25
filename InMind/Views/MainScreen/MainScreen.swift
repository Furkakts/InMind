import SwiftUI

struct MainScreen: View {
    @StateObject var coreDataModel: CoreData
    @State private var isPasswordShown = true
    @State private var isCommentShown = false

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
            UITabBar.appearance().backgroundColor = UIColor(Color("SecondaryColor"))
        }
    }

    func firstTabItem() -> some View {
        return
            ZStack {
                Color("MainColor").ignoresSafeArea(edges: .top)
                Group {
                    if coreDataModel.passwords.isEmpty {
                        contentUnavailable
                    } else { passwordList }
                }
            }
    }

    var contentUnavailable: some View {
        VStack(spacing:30){
            Image(systemName:"note.text.badge.plus")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundStyle(Color("SecondaryColor"))
            
            Text("There is nothing to show now. You can see your passwords and related information here if you add password.")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(Color("SecondaryColor"))
                .kerning(1.0)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(width: 300, height: 300)
        
    }

    var passwordList: some View {
        NavigationStack {
            List(coreDataModel.passwords){password in
                NavigationLink(value: password) {
                    VStack(spacing: 20){
                        HStack(spacing: 10){
                            Text("Username:")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(Color("SecondaryColor"))
                            Text(password.name ?? "")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(Color("SecondaryColor"))
                            Spacer()
                            Image(systemName:"doc.on.doc")
                                .imageScale(.medium)
                                .foregroundStyle(Color("SecondaryColor"))
                                .onTapGesture {
                                    copy(copiedText: password.name ?? "")
                                }
                        }
                        
                        HStack(spacing:10){
                            Text("Password:")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(Color("SecondaryColor"))
                            Text(isPasswordShown ? (password.password ?? "") : "***********")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(Color("SecondaryColor"))
                            Spacer()
                            Image(systemName:isPasswordShown ? "eye.slash.fill" : "eye.fill")
                                .imageScale(.medium)
                                .foregroundStyle(Color("SecondaryColor"))
                                .onTapGesture {
                                    withAnimation(.linear){
                                        isPasswordShown.toggle()
                                    }
                                }
                            Image(systemName:"doc.on.doc")
                                .imageScale(.medium)
                                .padding(.leading, 15)
                                .foregroundStyle(Color("SecondaryColor"))
                                .onTapGesture {
                                    copy(copiedText: password.password ?? "")
                                }
                        }
                        if isCommentShown {
                            Text("Comment:")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(Color("SecondaryColor"))
                            Text(password.comment ?? "")
                                .font(.body)
                                .fontWeight(.medium)
                                .frame(height: 50)
                                .minimumScaleFactor(0.5)
                        }
                        
                        Image(systemName: "chevron.down")
                            .imageScale(.medium)
                            .foregroundStyle(Color("SecondaryColor"))
                            .rotationEffect(Angle(degrees:isCommentShown ? 180 : 0))
                            .onTapGesture {
                                withAnimation(.easeOut){
                                    isCommentShown.toggle()
                                }
                            }
                    }
                    .padding()
                    .background(Color("MainColor"), in:RoundedRectangle(cornerRadius: 5))
                }
                
            }
           
           
            .navigationDestination(for: PasswordEntity.self){ _ in
                EmptyView()
            }
        }
    }
   
    func copy(copiedText:String) {
        UIPasteboard.general.string = copiedText
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(coreDataModel: CoreData())
    }
}
