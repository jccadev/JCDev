//
//  TabViewMain.swift
//  JCDev
//
//  Created by Mia Mawby on 9/5/2023.
//

import SwiftUI

struct TabMain: View {
    @State private var selectedTab: Tab = .MainView
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack{
            VStack{
                TabView(selection: $selectedTab) {
                    if selectedTab == .MainView {
                        MainView()
                        
                    } else {
                        if selectedTab == .Settings {
                            Settings()
                            
                        } else {
                            if selectedTab == .Downloads {
                              Downloads()
                                
                            } else {
                                if selectedTab == .Bard {
                                    OpenAINavigation()
                                    
                                }
                            }
                        }
                    }
                    
                    }
                   
                
                }
            .overlay(alignment: .bottom) {
                TabViewConfiguration(selectedTab: $selectedTab)
                    
            }
            
            }
            
                
            
        }
    }


struct TabMain_Previews: PreviewProvider {
    static var previews: some View {
        TabMain()
    }
}

