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
        VStack(spacing: 30) {
            Image(systemName: "note.text.badge.plus")
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
        ScrollView(.vertical) {
            ForEach(coreDataModel.passwords) { password in
                VStack(spacing: 10) {
                    HStack(spacing: 20) {
                        Text("Username:")
                            .padding(.leading, 20)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("MainColor"))
                        Text(password.name ?? "NaN")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("MainColor"))
                        Spacer()
                        Image(systemName: "doc.on.doc")
                            .imageScale(.medium)
                            .padding(.trailing, 20)
                            .foregroundStyle(Color("MainColor"))
                            .onTapGesture {
                                copy(copiedText: password.name ?? "NaN")
                            }
                    }

                    HStack(spacing: 20) {
                        Text("Password:")
                            .padding(.leading, 20)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("MainColor"))
                        Text(isPasswordShown ? (password.password ?? "NaN") : "*****")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("MainColor"))
                        Spacer()
                        Image(systemName: isPasswordShown ? "eye.slash.fill" : "eye.fill")
                            .imageScale(.medium)
                            .foregroundStyle(Color("MainColor"))
                            .onTapGesture {
                                withAnimation(.linear(duration: 0.2)) {
                                    isPasswordShown.toggle()
                                }
                            }
                        Image(systemName: "doc.on.doc")
                            .imageScale(.medium)
                            .padding(.trailing, 20)
                            .foregroundStyle(Color("MainColor"))
                            .onTapGesture {
                                copy(copiedText: password.password ?? "")
                            }
                    }
                    VStack(alignment: .leading) {
                        HStack(spacing: 20){
                            Text("Comment:")
                                .padding(.leading, 20)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color("MainColor"))
                            
                            Image(systemName: "chevron.down")
                                .imageScale(.medium)
                                .foregroundStyle(Color("MainColor"))
                                .rotationEffect(Angle(degrees: isCommentShown ? 180 : 0))
                                .onTapGesture {
                                    withAnimation(.easeOut) {
                                        isCommentShown.toggle()
                                    }
                                }
                        }
                        .padding(.top, 15)
                        if isCommentShown {
                            Divider()
                                .background(Color("MainColor"))
                            Text(password.comment ?? "NaN")
                                .padding(.leading, 30)
                                .frame(height: 30)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color("MainColor"))
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                
                        }
                    }
                    
                }
                .padding()
                .background(Color("SecondaryColor"), in: RoundedRectangle(cornerRadius: 5))
            }
        }
        .padding()
    }

    func copy(copiedText: String) {
        UIPasteboard.general.string = copiedText
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(coreDataModel: CoreData())
    }
}
