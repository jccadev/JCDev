//
//  AuthView.swift
//  JCDev
//
//  Created by Mia Mawby on 14/5/2023.
//

import SwiftUI
import LocalAuthentication

struct AuthView: View {
    @State private var isUnlocked = false
    @State private var StatusMessage = ""
    @EnvironmentObject var userAuth: userAuth
    
    var body: some View {
        
        
        
        VStack{
            if isUnlocked {
                TabMain()
            } else{
                VStack{
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(20)
                    
                    Text("Oops! Something Bad Happened.")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    Text("Error Message: \(StatusMessage)")
                    
                }
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "In order to Quick Sign-In you need to authenticate yourself"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationErrror in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        print("There was a problem continuing, if this error persists contact us")
                        self.StatusMessage = "There was a problem continuing, if this error persists contact us"
                        
                    }
                }
                
            }
        } else {
            print("You need to have a device with biometrics enabled")
            self.StatusMessage = "You need to have a device with biometrics enabled"
            
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
