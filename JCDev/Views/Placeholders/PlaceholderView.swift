//
//  DownloadsPlaceHolder.swift
//  JCDev
//
//  Created by Mia Mawby on 1/5/2023.
//

import SwiftUI
import RiveRuntime

struct PlaceHolderView: View {
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
                
                Text("Coming Soon!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)
            }
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25, style: .continuous))
        }
    }
}

struct DownloadsPlaceHolder_Previews: PreviewProvider {
    static var previews: some View {
        PlaceHolderView()
    }
}
