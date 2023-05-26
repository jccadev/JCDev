//
//  Settings.swift
//  JCDev
//
//  Created by Mia Mawby on 27/4/2023.
//

import SwiftUI
import Firebase

struct Settings: View {
    @EnvironmentObject var userAuth: userAuth
    @State var email: String = ""
    @State var StatusMessage: String = ""
    @State var plan: String = ""
    @State var showingAlert = false
    var body: some View {
        NavigationStack{
            List{
                if userAuth.animationvar {
                    Section{
                        
                        Button{
                            userAuth.animationOff()
                        }label: {
                            Text(Image(systemName: "dial.low"))
                            +
                            Text(" Turn Off Animations")
                            
                        }
                        
                        NavigationLink(destination: versionid()) {
                            Label("Build Version", systemImage: "hammer.fill")
                        }
                        
                        NavigationLink(destination: model()) {
                            Label("Device", systemImage: "iphone")
                        }
                    }
                } else {
                    Section{
                        
                        Button{
                            userAuth.animationOn()
                        }label: {
                            Text(Image(systemName: "dial.high"))
                            +
                            Text(" Turn On Animations")
                            
                        }
                        
                        NavigationLink(destination: versionid()) {
                            Label("Build Version", systemImage: "hammer.fill")
                        }
                        
                        NavigationLink(destination: model()) {
                            Label("Device", systemImage: "iphone")
                        }
                    }
                }
                
                if plan == "Admin" {
                    if userAuth.adminvar {
                        Section{
                            Button{
                                ResetPass()
                            }label: {
                                Text(Image(systemName: "envelope.badge.shield.half.filled"))
                                +
                                Text(" Reset Password")
                                
                            }
                            .foregroundColor(.blue)
                            
                            Button{
                                self.userAuth.logout()
                                
                            }label: {
                                Text(Image(systemName: "person.badge.minus"))
                                +
                                Text(" Sign Out")
                                
                            }
                            .foregroundColor(.red)
                            
                        }
                    } else {
                        Section{
                            
                            Button{
                                self.userAuth.adminlogin()
                            } label: {
                                Label("Admin Portal", systemImage: "person.fill")
                            }
                            
                            
                            Button{
                                ResetPass()
                            }label: {
                                Text(Image(systemName: "envelope.badge.shield.half.filled"))
                                +
                                Text(" Reset Password")
                                
                            }
                            .foregroundColor(.blue)
                            
                            Button{
                                self.userAuth.logout()
                                
                            }label: {
                                Text(Image(systemName: "person.badge.minus"))
                                +
                                Text(" Sign Out")
                                
                            }
                            .foregroundColor(.red)
                            
                        }
                    }
                    
                } else {
                    Section{
                        
                        Button{
                            ResetPass()
                        }label: {
                            Text(Image(systemName: "envelope.badge.shield.half.filled"))
                            +
                            Text(" Reset Password")
                            
                        }
                        .foregroundColor(.blue)
                        
                        Button{
                            self.userAuth.logout()
                            
                        }label: {
                            Text(Image(systemName: "person.badge.minus"))
                            +
                            Text(" Sign Out")
                            
                        }
                        .foregroundColor(.red)
                        
                        
                    }
                }
            }
        }
        .alert(StatusMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
        .onAppear {
            if let user = Auth.auth().currentUser {
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(user.uid)
                userRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let data = document.data()
                        email = data?["email"] as? String ?? ""
                        plan = data?["plan"] as? String ?? ""
                    }
                }
            }
        }
    }
    
    private func ResetPass() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            
            if let error = error {
                print("failed to send reset email:", error)
                self.StatusMessage = "Failed to send reset email: \(error)"
                self.showingAlert = true
                return
            }
            
            print("Check Your Email.")
            
            self.StatusMessage = "Check Your Email."
            self.showingAlert = true
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
