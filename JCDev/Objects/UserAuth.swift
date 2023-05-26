//
//  UserAuth.swift
//  JCDev
//
//  Created by Mia Mawby on 27/4/2023.
//

import Combine
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class userAuth: ObservableObject {
    @AppStorage("animationvar") var animationvar: Bool = true
    @AppStorage("DevChat1st?") var devchatfirst: Bool = true
    @Published var devchatfirstbackup: Bool = true
    @AppStorage("signIn") var isLoggedin: Bool = false
    @Published var email: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var adminvar: Bool = false
    @Published var webVar: Bool = false
    @Published var webURL: String = ""
    @Published var webTitle: String = ""
    @Published var webVersion: String = ""
    
    func FinishedSetupChat() {
        self.devchatfirstbackup = false
        UserDefaults.standard.set(false, forKey: "DevChat1st?")
    }
    
    func WebOn() {
        self.webVar = true
    }
    
    func WebOff() {
        self.webVar = false
    }
    
    func animationOff() {
        UserDefaults.standard.set(false, forKey: "animationvar")
    }
    
    func animationOn() {
        UserDefaults.standard.set(true, forKey: "animationvar")
    }
    
    func login() {
        if UIDevice.current.localizedModel == "iPhone" {
            self.adminvar = false
            UserDefaults.standard.set(true, forKey: "signIn")
        } else {
            self.adminvar = false
            UserDefaults.standard.set(true, forKey: "signIn")
            UserDefaults.standard.set(false, forKey: "animationvar")
        }
        
    }
    
    func adminlogin() {
        self.adminvar = true
    }
    
    func logout() {
        
      let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
                UserDefaults.standard.set(false, forKey: "isAdmin")
                UserDefaults.standard.set(false, forKey: "signIn")
            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
            }
        
    }
    
}

