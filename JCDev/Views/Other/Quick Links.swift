//
//  Quick Links.swift
//  JCDev
//
//  Created by Mia Mawby on 2/5/2023.
//

import SwiftUI

struct Quick_Links: View {
    var body: some View {
        NavigationStack{
            List{
                Link(destination: URL(string: "https://developer.apple.com/account/")!) {
                    Text(" Developer Website")
                }
                
                Link(destination: URL(string:"https://console.firebase.google.com/u/0/project/jcdevelopment/overview")!) {
                    Text(Image(systemName: "flame.fill"))
                    +
                    Text(" Firebase Website")
                }
                
                Link(destination: URL(string: "https://jcdevelopment.web.app/")!) {
                    Text("")
                    +
                    Text("JC")
                        .bold()
                    +
                    Text(" JCDev Website")
                }
                
            }
            
        }
    }
}

struct Quick_Links_Previews: PreviewProvider {
    static var previews: some View {
        Quick_Links()
    }
}
