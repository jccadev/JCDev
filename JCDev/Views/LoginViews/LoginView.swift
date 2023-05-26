//
//  LoginView.swift
//  JCDev
//
//  Created by Mia Mawby on 30/4/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import AuthenticationServices
import CryptoKit
import RiveRuntime
import GoogleSignInSwift
import GoogleSignIn

struct LoginView: View {
    @EnvironmentObject var userAuth: userAuth
    @State private var email = ""
    @State private var password = ""
    @State private var plan = ""
    @State private var admincontinue = false
    @State private var StatusMessage = ""
    @State var currentNonce: String?
    @State private var showingAlert = false
    @State var loadingTrigger = false
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      var randomBytes = [UInt8](repeating: 0, count: length)
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }

      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

      let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
      }

      return String(nonce)
    }
    
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
    var body: some View {
        ZStack {
            if userAuth.animationvar {
                RiveViewModel(fileName: "shapeslogin").view()
                    .blur(radius: 30)
                    .ignoresSafeArea()
            } else {
                LinearGradient(colors: [.cyan.opacity(0.7), .indigo.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
            }
            VStack(spacing: 16){
                
                VStack(spacing: 16) {
                    
                    Group {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(20)
                    
                    
                    Text("Welcome Back!")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    
                    
                    Text("Email")
                        .bold()
                        .offset(x: -140)
                    
                    
                    TextField("example@example.com", text: $email)
                        .keyboardType(.emailAddress)
                        .frame(width: 300)
                    
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
                        .autocapitalization(.none)
                    
                    Text("Password")
                    
                        .bold()
                        .offset(x: -125)
                    
                    SecureField("Password", text: $password)
                        .frame(width: 300)
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
                        .autocapitalization(.none)
                    
                    
                    
                    Button{
                        ResetPass()
                    }label: {
                        Text("Forgot Password?")
                            .bold()
                            .foregroundColor(.white)
                    }
                    
                    
                    Button {
                        self.loadingTrigger = true
                        LoginUser()
                    } label: {
                        Text("Sign In")
                            .foregroundColor(.black)
                            .frame(width: 200, height: 50)
                            .background(Color.white)
                            .cornerRadius(15)
                    }
                }
                Text("Or")
                    .foregroundColor(.white)
                    .bold()
                
                    Button {
                        GoogleLogin()
                    } label: {
                        HStack{
                            Image("googlelogo")
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                            Text("Sign in with Google")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                        }
                        .frame(width: 300, height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.white))
                    }
                    
                    
                   
                    
                    
                SignInWithAppleButton(
                    onRequest: { request in
                        let nonce = randomNonceString()
                        currentNonce = nonce
                        request.requestedScopes = [.fullName, .email]
                        request.nonce = sha256(nonce)
                    },
                    onCompletion: { result in
                        switch result {
                        case .success(let authResults):
                            switch authResults.credential {
                            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                
                                guard let nonce = currentNonce else {
                                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                                }
                                guard let appleIDToken = appleIDCredential.identityToken else {
                                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                                }
                                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                    print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                    return
                                }
                                
                                let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                                Auth.auth().signIn(with: credential) { (authResult, error) in
                                    if (error != nil) {
                                        // Error. If error.code == .MissingOrInvalidNonce, make sure
                                        // you're sending the SHA256-hashed nonce as a hex string with
                                        // your request to Apple.
                                        print(error?.localizedDescription as Any)
                                        return
                                    }
                                    
                                    
                                    
                                    
                                    
                                    self.StatusMessage = "If this is your first login and you dont have an account, reset your password in settings -> Account"
                                    
                                    self.showingAlert = true
                                    
                                    self.userAuth.login()
                                }
                                
                                print("\(String(describing: Auth.auth().currentUser?.uid))")
                            default:
                                break
                                
                            }
                        default:
                            break
                        }
                        
                    }
                )
                .frame(width: 300, height: 50)
                .cornerRadius(15)
                .signInWithAppleButtonStyle(.white)
                    
                    
                
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30))
            }
            .overlay {
                if loadingTrigger{
                    LoadingView()
                } else {
                  
                }
            }
            .alert(StatusMessage, isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
        private func ResetPass() {
            self.loadingTrigger = true
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
                self.loadingTrigger = false
            }
        }
    
    private func GoogleLogin() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) {  result, error in
            guard error == nil else {
                // ...
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                // ...
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("failed to login user:", error)
                    self.StatusMessage = "Failed to login user: \(error)"
                    self.loadingTrigger = false
                    self.showingAlert = true
                    return
                }
                
                print("successful")
                userAuth.login()
            }
        }
    }
    
    private func LoginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            
            if let err = err {
                print("failed to login user:", err)
                self.StatusMessage = "Failed to login user: \(err)"
                self.loadingTrigger = false
                self.showingAlert = true
                return
            }
            
           
            
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            
            
            self.StatusMessage = " Successfully logged in as user: \(result?.user.uid ?? "")"
            self.userAuth.login()
            
            
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
