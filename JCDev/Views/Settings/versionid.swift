//
//  versionid.swift
//  JCDev
//
//  Created by Mia Mawby on 30/4/2023.
//

import SwiftUI
import RiveRuntime

struct versionid: View {
    @EnvironmentObject var userAuth: userAuth
    var body: some View {
        ZStack{
            if userAuth.animationvar {
                RiveViewModel(fileName: "shapes").view()
                    .blur(radius: 30)
                    .ignoresSafeArea()
            } else {
                LinearGradient(colors: [.cyan.opacity(0.7), .indigo.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
            }
            VStack{
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
                
                Text("Version:")
                    .font(.largeTitle)
                    .bold()
                
                Text("7.1")
            }
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25))
        }
    
    }
}

struct versionid_Previews: PreviewProvider {
    static var previews: some View {
        versionid()
    }
}
