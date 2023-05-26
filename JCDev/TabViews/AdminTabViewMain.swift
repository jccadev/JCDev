//
//  TabViewMain.swift
//  JCDev
//
//  Created by Mia Mawby on 9/5/2023.
//

import SwiftUI

struct AdminTabViewMain: View {
    @State private var AdminselectedTab: AdminTab = .AdminView
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack{
            VStack{
                TabView(selection: $AdminselectedTab) {
                    if AdminselectedTab == .AdminView {
                        AdminView()
                        
                    } else {
                        if AdminselectedTab == .Bard {
                           OpenAINavigation()
                            
                        } else {
                            if AdminselectedTab == .FirebaseView {
                              FirebaseView()
                                
                            } else {
                                if AdminselectedTab == .Downloads {
                                    Downloads()
                                    
                                } else {
                                    if AdminselectedTab == .Settings {
                                        Settings()
                                    }
                                }
                            }
                        }
                    }
                    
                    }
                   
                
                }
            .overlay(alignment: .bottom) {
                AdminTabViewConfiguration(AdminselectedTab: $AdminselectedTab)
                    
            }
            
            }
            
                
            
        }
    }


struct AdminTabViewMain_Previews: PreviewProvider {
    static var previews: some View {
        AdminTabViewMain()
    }
}
