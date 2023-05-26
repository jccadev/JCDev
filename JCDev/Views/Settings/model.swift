//
//  model.swift
//  JCDev
//
//  Created by Mia Mawby on 30/4/2023.
//

import SwiftUI
import RiveRuntime


struct model: View {
    @EnvironmentObject var userAuth: userAuth
    var body: some View {
        ZStack{
            if userAuth.animationvar {
                RiveViewModel(fileName: "shapesadmin").view()
                    .blur(radius: 30)
                    .ignoresSafeArea()
            } else {
                LinearGradient(colors: [.cyan.opacity(0.7), .indigo.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
            }
            VStack{
                Text("You're Using a \(UIDevice.current.localizedModel)")
                    .font(.largeTitle)
                    .bold()
            }
        }
    }
}

struct model_Previews: PreviewProvider {
    static var previews: some View {
        model()
    }
}
