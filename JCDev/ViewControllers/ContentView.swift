//
//  ContentView.swift
//  JCDev
//
//  Created by Mia Mawby on 27/4/2023.
//

import SwiftUI
import Firebase
import AuthenticationServices


struct ContentView: View {
    @EnvironmentObject var userAuth: userAuth
    @State private var isUnlocked = false
    
    var body: some View {
        if !userAuth.isLoggedin{
            LoginView()
        } else {
            if userAuth.adminvar{
                
                AdminTabViewMain()
                
            } else {
                TabMain()
                
            }
           
        }
    }
}
  

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

