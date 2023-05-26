//
//  ChatLoadingView.swift
//  JCDev
//
//  Created by Mia Mawby on 22/5/2023.
//

import SwiftUI

struct ChatLoadingView: View {
    var body: some View {
       
            
            HStack(spacing: 15){
                ProgressView()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .cornerRadius(10)
                    .shadow(color: .blue, radius: 5)
                
                Text("DevAI is thinking...")
                    .fontWeight(.semibold)
            }
        
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
    }
}

struct ChatLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ChatLoadingView()
    }
}
