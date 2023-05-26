//
//  OpenAINavigation.swift
//  JCDev
//
//  Created by Mia Mawby on 15/5/2023.
//

import SwiftUI
import RiveRuntime

struct OpenAINavigation: View {
    @EnvironmentObject var userAuth: userAuth
    @State var sheetShowing = false
    var body: some View {
        NavigationStack{
            ZStack{
                if userAuth.animationvar {
                    RiveViewModel(fileName: "shapesadmin").view()
                        .blur(radius: 30)
                        .ignoresSafeArea()
                } else {
                    LinearGradient(colors: [.cyan.opacity(0.7), .indigo.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea()
                }
                
                ScrollView{
                    VStack(spacing: 16){
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                            .shadow(color: .blue, radius: 15)
                        
                        Text("Welcome To DevAI")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        
                        Button{
                            sheetShowing = true
                        } label: {
                            Label("Learn More", systemImage: "arrow.right.circle.fill")
                                .foregroundColor(.white)
                                .bold()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.blue))
                        
                        
                    }
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                    Spacer(minLength: 200)
                    VStack{
                        NavigationLink(destination: ChatView()) {
                            Label("DevAI CHAT", systemImage: "message.fill")
                        }
                        .frame(width: 300, height: 50)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                        
                        NavigationLink(destination: DevAIPics()) {
                            Label("DevAI PICS", systemImage: "photo")
                        }
                        .frame(width: 300, height: 50)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    
                }
            }
            .navigationTitle("DevAI")
            
        }
        .sheet(isPresented: $sheetShowing) {
            ChatSetup()
                .overlay {
                ZStack {
                    Color.clear
                    .background(.ultraThinMaterial)
                    .frame(height: 50)
                    HStack{
                        Text("About DevAI")
                            .bold()
                            .frame(minWidth: 0, alignment: .leading)
                            .padding(.leading, 20)
                        Button{
                            sheetShowing = false
                        } label: {
                            Text("Done")
                                .bold()
                        }
                        .frame(minWidth: 0, alignment: .trailing)
                        .padding(.trailing, 20)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                
            }
        }
    }
}

struct OpenAINavigation_Previews: PreviewProvider {
    static var previews: some View {
        OpenAINavigation()
    }
}
