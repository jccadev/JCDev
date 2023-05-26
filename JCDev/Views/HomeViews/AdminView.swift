
import SwiftUI
import Firebase
import RiveRuntime

struct AdminView: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var profilepic = ""
    @State var isverified = false
    @State var userID = ""
    @State var email = ""
    @State var sheetShows = false
    @State var sheetShows2 = false
    @State var sheetShows3 = false
    @State var sheetShows4 = false
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userAuth: userAuth
    
    var body: some View {
        NavigationStack {
            ZStack{
                if userAuth.animationvar {
                    RiveViewModel(fileName: "shapesadmin").view()
                        .blur(radius: 30)
                        .ignoresSafeArea()
                } else {
                    LinearGradient(colors: [.cyan.opacity(0.7), .indigo.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea()
                }
                VStack (spacing: 16){
                    VStack{
                        Text("Meet DevAI")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .shadow(radius: 10)
                        
                        Button{
                            sheetShows = true
                        } label: {
                            
                            Label("Try It Out Here", systemImage: "sparkles")
                                .fontWeight(.bold)
                                .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .topTrailing))
                        }
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                        
                    }
                    .frame(width: 300)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                    
                    
                    Button{
                        sheetShows2 = true
                    } label: {
                        Label("Firebase Console", systemImage: "flame")
                            .foregroundColor(colorScheme == .light ? .black : .white)
                    }
                    .frame(width: 300, height: 50)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                    
                    Button{
                        sheetShows3 = true
                    } label: {
                        Label("Quick Links", systemImage: "link")
                            .foregroundColor(colorScheme == .light ? .black : .white)
                    }
                    .frame(width: 300, height: 50)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                    
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                .frame(width: 370)
            }
        }
        .sheet(isPresented: $sheetShows, content: {
            VStack{
                OpenAINavigation()
            }
            .overlay {
                ZStack {
                    Color.clear
                    .background(.ultraThinMaterial)
                    .frame(height: 50)
                    HStack{
                        Text("DevAI")
                            .bold()
                            .frame(minWidth: 0, alignment: .leading)
                            .padding(.leading, 20)
                        Button{
                            sheetShows = false
                        } label: {
                            Text("Done")
                                .bold()
                        }
                        .frame(minWidth: 0, alignment: .trailing)
                        .padding(.trailing, 20)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                
            }
        })
        .sheet(isPresented: $sheetShows4, content: {
            VStack{
                AccountDetails()
            }
            .overlay {
                ZStack {
                    Color.clear
                    .background(.ultraThinMaterial)
                    .frame(height: 50)
                    HStack{
                        Text("Account")
                            .bold()
                            .frame(minWidth: 0, alignment: .leading)
                            .padding(.leading, 20)
                        Button{
                            sheetShows4 = false
                        } label: {
                            Text("Done")
                                .bold()
                        }
                        .frame(minWidth: 0, alignment: .trailing)
                        .padding(.trailing, 20)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                
            }
        })
        .sheet(isPresented: $sheetShows2, content: {
            VStack{
                FirebaseView()
            }
            .overlay {
                ZStack {
                    Color.clear
                    .background(.ultraThinMaterial)
                    .frame(height: 50)
                    HStack{
                        Text("Firebase")
                            .bold()
                            .frame(minWidth: 0, alignment: .leading)
                            .padding(.leading, 20)
                        Button{
                            sheetShows2 = false
                        } label: {
                            Text("Done")
                                .bold()
                        }
                        .frame(minWidth: 0, alignment: .trailing)
                        .padding(.trailing, 20)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                
            }
        })
        .sheet(isPresented: $sheetShows3, content: {
            VStack{
                Quick_Links()
            }
            .padding(.top, 50)
            .overlay {
                ZStack {
                    Color.clear
                    .background(.ultraThinMaterial)
                    .frame(height: 50)
                    HStack{
                        Text("Quick Links")
                            .bold()
                            .frame(minWidth: 0, alignment: .leading)
                            .padding(.leading, 20)
                        Button{
                            sheetShows3 = false
                        } label: {
                            Text("Done")
                                .bold()
                        }
                        .frame(minWidth: 0, alignment: .trailing)
                        .padding(.trailing, 20)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                
            }
        })
        
        .overlay{
            ZStack{
                Color.clear
                    .background(.ultraThinMaterial)
                    .frame(height: 100)
                HStack{
                    
                    
                    if isverified {
                        HStack{
                            Text("Hi, \(firstName) ")
                                .font(.system(size: 30, weight: .bold))
                            +
                            Text(Image(systemName: "checkmark.circle.fill"))
                                .foregroundColor(.blue)
                                .font(.system(size: 20))
                        }
                        .padding(.leading, 25)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        Text("Hi, \(firstName)")
                            .font(.largeTitle.weight(.bold))
                            .padding(.leading, 25)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Button{
                        sheetShows4 = true
                    } label: {
                        AsyncImage(url: URL(string: profilepic)) { image in
                            image.resizable()
                            
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 40, height: 40)
                        .cornerRadius(15)
                        .padding(7)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                        .padding(.trailing, 25)
                        
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .onAppear{
                if let user = Auth.auth().currentUser {
                    let db = Firestore.firestore()
                    let userRef = db.collection("users").document(user.uid)
                    userRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let data = document.data()
                            firstName = data?["firstName"] as? String ?? ""
                            profilepic = data?["profilePicURL"] as? String ?? ""
                            isverified = data?["verified"] as? Bool ?? false
                        }
                    }
                }
            }
        }
        
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}

