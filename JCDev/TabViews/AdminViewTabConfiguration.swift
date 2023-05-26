

//
//  TabViewConfiguration.swift
//  JCDev
//
//  Created by Mia Mawby on 27/4/2023.
//

import SwiftUI

enum AdminTab: String, CaseIterable {
    case AdminView = "house"
    case Bard = "sparkles"
    case FirebaseView = "flame"
    case Downloads = "arrow.down.circle"
    case Settings = "gearshape"
}

struct AdminTabViewConfiguration: View {
    @Binding var AdminselectedTab: AdminTab
    private var fillImage: String {
        if AdminselectedTab == .Bard {
            return(AdminselectedTab.rawValue + "")
        } else {
            
            return (AdminselectedTab.rawValue + ".fill")
        }
    }
    
    
    
    var body: some View {
        VStack{
            HStack{
                ForEach(AdminTab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: AdminselectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(AdminselectedTab == tab ? 1.25 : 1.0)
                        .foregroundColor(AdminselectedTab == tab ? .blue : .gray)
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                AdminselectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
        }
        .frame(maxWidth: 500)
        .frame(height: 60)
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .padding()
    }
}

struct AdminTabViewConfiguration_Previews: PreviewProvider {
    static var previews: some View {
        AdminTabViewConfiguration(AdminselectedTab: .constant(.AdminView))
    }
}
