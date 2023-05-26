//
//  Navbars.swift
//  JCDev
//
//  Created by Mia Mawby on 23/5/2023.
//

import SwiftUI
import Firebase

struct Navbars: View {
    @State var firstName = ""
    @State var profilepic = ""
    @State var isverified = false
    var body: some View {
        ZStack{
            Color.clear
                .background(.ultraThinMaterial)
                .frame(height: 100)
            HStack{
                Text("Hi, \(firstName)")
                    .font(.largeTitle.weight(.bold))
                    .padding(.leading, 25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                AsyncImage(url: URL(string: profilepic)) { image in
                    image.resizable()
                        
                } placeholder: {
                    LoadingView()
                }
                .frame(width: 40, height: 40)
                .cornerRadius(15)
                .padding(7)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                .padding(.trailing, 25)
                
                
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

struct Navbars_Previews: PreviewProvider {
    static var previews: some View {
        Navbars()
    }
}
