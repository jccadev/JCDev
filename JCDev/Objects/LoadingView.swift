//
//  LoadingView.swift
//  JCDev
//
//  Created by Mia Mawby on 10/5/2023.
//

import SwiftUI
import RiveRuntime

struct LoadingView: View {
    var body: some View {
        ZStack{
            Circle()
                .foregroundStyle(.thinMaterial)
                .frame(width: 50)
                .shadow(radius: 20)
                .animation(.easeIn, value: 1)
            
            RiveViewModel(fileName: "loader").view()
                .frame(width: 50)
                .offset(x: 0, y: 4)
                .shadow(radius: 5)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
