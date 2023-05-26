//
//  AccountDetails.swift
//  JCDev
//
//  Created by Mia Mawby on 30/4/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage
import PhotosUI
import RiveRuntime

struct AccountDetails: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var plan = ""
    @State var devices = ""
    @State var userID = ""
    @State var email = ""
    @State var username = ""
    @State var profilepic = ""
    @State var changingUsername = false
    @State var changedUsername = ""
    @State var isverified = false
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    @State var loadingTrigger = false
    @EnvironmentObject var userAuth: userAuth
    var body: some View {
        ZStack{
            if userAuth.animationvar {
                RiveViewModel(fileName: "shapesaccount").view()
                    .blur(radius: 30)
                    .ignoresSafeArea()
            } else {
                LinearGradient(colors: [.cyan.opacity(0.7), .indigo.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
            }
            VStack{
                
                if selectedImage != nil{
                    VStack{
                        VStack{
                            Text("PREVIEW")
                                .bold()
                                .foregroundColor(.white)
                            
                            
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100.0, height: 100.0, alignment: .center)
                                .clipShape(Circle())
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.blue))
                        
                        VStack{
                            Button{
                                self.loadingTrigger = true
                                uploadPhoto()
                            } label: {
                                Text(Image(systemName: "arrow.up.circle"))
                                    .bold()
                                    .foregroundColor(.white)
                                +
                                Text(" Upload image")
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.blue))
                        }
                    }
                    
                } else {
                    AsyncImage(url: URL(string: profilepic)) { image in
                        image.resizable()
                            
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .scaledToFill()
                }
                    
                
                
                Text("\(firstName) \(lastName) ")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 3)
                
                if isverified {
                    Text("@\(username) ")
                        .bold()
                    +
                    Text(Image(systemName: "checkmark.circle.fill"))
                        .foregroundColor(.blue)
                } else {
                    Text("@\(username)")
                        .bold()
                        
                }
                    
                
                Text("\(plan) User")
                    .bold()
                    .textCase(.uppercase)
                    .padding(.top, 3)
                    
                    
                
                Text("Your Email: \(email)")
                    
                
                Text("If You Need It, Here is Your UID: \(userID) ")
                    
                
                Text("If you need to change anything use our support form at jcdevelopment.web.app")
                    .foregroundColor(.blue)
                    .bold()
                HStack{
                    Button{
                        isPickerShowing = true
                    } label: {
                        Text(Image(systemName: "pencil.circle.fill"))
                            .bold()
                            .foregroundColor(.white)
                        +
                        Text(" Change Profile Pic")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.blue))
                    
                    Button{
                        changingUsername = true
                    } label: {
                        Text("@")
                            .bold()
                            .foregroundColor(.white)
                        +
                        Text(" Change username")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.blue))
                    
                }
                
                
            }
            .padding()
            
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25))
            .frame(width: 350, height: 500)
        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil, content: {
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
        })
        .overlay{
            if changingUsername {
                
                VStack(spacing: 16){
                    
                    Button{
                        self.changingUsername = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .offset(x: -150)
                    
                    Text("Let's Change Your Username")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                    
                    TextField("@newusername", text: $changedUsername)
                        .keyboardType(.twitter)
                        .frame(width: 300)
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
                        .autocapitalization(.none)
                    
                    Button {
                        self.loadingTrigger = true
                        ChangeUsername()
                    } label: {
                        Text("Change")
                            .foregroundColor(.black)
                            .frame(width: 200, height: 50)
                            .background(Color.white)
                            .cornerRadius(15)
                    }
                    
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
            } else {
                
            }
        }
        .overlay{
            if loadingTrigger {
                LoadingView()
            } else {
                
            }
        }
        .onAppear {
            if let user = Auth.auth().currentUser {
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(user.uid)
                userRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let data = document.data()
                        firstName = data?["firstName"] as? String ?? ""
                        plan = data?["plan"] as? String ?? ""
                        devices = data?["registeredDevices"] as? String ?? ""
                        lastName = data?["lastName"] as? String ?? ""
                        userID = data?["uid"] as? String ?? ""
                        email = data?["email"] as? String ?? ""
                        profilepic = data?["profilePicURL"] as? String ?? ""
                        username = data?["username"] as? String ?? ""
                        isverified = data?["verified"] as? Bool ?? false
                    }
                }
            }
        }
        
    }
    
    func ChangeUsername() {
        self.changingUsername = false
        
        var filteredText: String {
                let forbiddenCharacters = "@!()*&^%$#<>?/\\{}[]:;~`.| "
                return changedUsername
                    .replacingOccurrences(of: " ", with: "")
                    .filter { !forbiddenCharacters.contains($0) }
            }
        
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(user.uid).setData([
               "firstName": firstName,
               "lastName": lastName,
               "email": email,
               "plan": plan,
               "registeredDevices": devices,
               "uid": userID,
               "profilePicURL": profilepic,
               "username": filteredText,
               "verified": isverified
            ])
            
        }
        self.loadingTrigger = false
    }
    
    func uploadPhoto() {
        
        guard selectedImage != nil else {
            return
        }
        
        let storageRef = Storage.storage().reference()
        
        let imageData = selectedImage!.jpegData(compressionQuality: 1.0)
        
        guard imageData != nil else {
            return
        }
        
        let path = "profilePictures/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        let uploadTask = fileRef.putData(imageData!, metadata: nil) {
            metadata, error in
            
            if error == nil && metadata != nil {
                
                        let storageRef = Storage.storage().reference(withPath: path)
                         storageRef.downloadURL { (url, error) in
                                if error != nil {
                                    print((error?.localizedDescription)!)
                                    return
                         }
                             let urlString = url!.absoluteString
                             
                             if let user = Auth.auth().currentUser {
                                 let db = Firestore.firestore()
                                 let userRef = db.collection("users").document(user.uid).setData([
                                    "firstName": firstName,
                                    "lastName": lastName,
                                    "email": email,
                                    "plan": plan,
                                    "registeredDevices": devices,
                                    "uid": userID,
                                    "profilePicURL": urlString,
                                    "username": username,
                                    "verified": isverified
                                 ])
                                 
                             }
                             
                             self.selectedImage = nil
                             self.loadingTrigger = false
                   }
                 
            }
            
        }
    }
}

struct AccountDetails_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetails()
    }
}
