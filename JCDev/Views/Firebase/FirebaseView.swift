//
//  FirebaseView.swift
//  JCDev
//
//  Created by Mia Mawby on 2/5/2023.
//

import SwiftUI
import RiveRuntime
import WebKit

struct FirebaseView: View {
    @State var isShowingOverlay = false
    var body: some View {
        ZStack{
            
            
            VStack(spacing: 16){
                WebView(urlToDisplay: URL(string: "https://console.firebase.google.com/u/0/project/jcdevelopment/overview")!)
                
            }
            
            if isShowingOverlay{
                Button{
                    self.isShowingOverlay = false
                } label: {
                    Text(Image(systemName: "xmark"))
                        .foregroundColor(.white)
                        .bold()
                }
                .padding()
                .background(Circle().foregroundColor(.blue))
                .offset(x: 150, y: 250)
            } else {
                Button{
                    self.isShowingOverlay = true
                } label: {
                    Text(Image(systemName: "character.textbox"))
                        .foregroundColor(.white)
                        .bold()
                }
                .padding()
                .background(Circle().foregroundColor(.blue))
                .offset(x: 150, y: 250)
            }
        }
        .overlay {
            if isShowingOverlay{
                VStack{
                    
                    Text("Sign In With These Credentials:")
                        .fontWeight(.heavy)
                    VStack{
                        Text("Email:")
                            .bold()
                            .offset(x: -80, y: 2)
                            .padding(.top, 2)
                        HStack{
                            Text("devjcca@icloud.com")
                            Button{
                                copyToClipboard(text: "devjcca@icloud.com")
                                self.isShowingOverlay = false
                            } label: {
                                Image(systemName: "doc.on.doc")
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                    }
                    
                    VStack{
                        Text("Password:")
                            .bold()
                            .offset(x: -60, y: 2)
                            .padding(.top, 2)
                        HStack{
                            Text("Jcca2023!")
                                .foregroundColor(.blue)
                            Button{
                                copyToClipboard(text: "Jcca2023!")
                                self.isShowingOverlay = false
                            } label: {
                                Image(systemName: "doc.on.doc")
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                    }
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25))
            }
        }
    }
    private func copyToClipboard(text: String) {
        UIPasteboard.general.string = text
    }
}

struct FirebaseView_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseView()
    }
}
