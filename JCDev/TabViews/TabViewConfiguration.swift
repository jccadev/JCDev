//
//  TabViewConfiguration.swift
//  JCDev
//
//  Created by Mia Mawby on 27/4/2023.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case MainView = "house"
    case Bard = "sparkles"
    case Downloads = "arrow.down.circle"
    case Settings = "gearshape"
}

struct TabViewConfiguration: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
        if selectedTab == .Bard {
            return(selectedTab.rawValue + "")
        } else {
            
            return (selectedTab.rawValue + ".fill")
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                        .foregroundColor(selectedTab == tab ? .blue : .gray)
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
        }
        .frame(maxWidth: 400)
        .frame(height: 60)
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .padding()
    }
}

struct TabViewConfiguration_Previews: PreviewProvider {
    static var previews: some View {
        TabViewConfiguration(selectedTab: .constant(.MainView))
    }
}
