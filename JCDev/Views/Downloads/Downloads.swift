//
//  Downloads.swift
//  JCDev
//
//  Created by Mia Mawby on 27/4/2023.
//

import SwiftUI

struct Downloads: View {
    
    var body: some View {
        NavigationStack{
            
                List{
                    Section{
                        Text(Image(systemName: "iphone"))
                            .font(.largeTitle)
                        +
                        Text(" iOS")
                            .font(.largeTitle)
                            .bold()
                        NavigationLink(destination: iOSDownloads()) {
                            Label("iPSW Files", systemImage: "apps.iphone")
                        }
                        
                        Link(destination: URL(string:"https://firebasestorage.googleapis.com/v0/b/jcdevelopment.appspot.com/o/betaProfiles%2FiOS_16_Beta_Profile.mobileconfig?alt=media&token=7116b283-a9cb-4679-a965-cf337754066a")!) {
                            Label("Beta Profiles (Depreciated)", systemImage: "doc.badge.gearshape.fill")
                        }
                        
                        
                    }
                    
                    Section{
                        Text(Image(systemName: "ipad.landscape"))
                            .font(.largeTitle)
                        +
                        Text(" iPadOS")
                            .font(.largeTitle)
                            .bold()
                        NavigationLink(destination: iPadOSDownloads()) {
                            Label("iPSW Files", systemImage: "apps.ipad.landscape")
                        }
                        Link(destination: URL(string:"https://firebasestorage.googleapis.com/v0/b/jcdevelopment.appspot.com/o/betaProfiles%2FiOS_iPadOS_16_Beta_Profile.mobileconfig?alt=media&token=11194eba-6c9e-478c-bea3-02d9db170afe")!) {
                            Label("Beta Profiles (Depreciated)", systemImage: "doc.badge.gearshape.fill")
                        }
                    }
                    
                    Section{
                        Text(Image(systemName: "laptopcomputer"))
                            .font(.largeTitle)
                        
                        
                        +
                        Text(" macOS (Apple Silicon)")
                            .font(.largeTitle)
                            .bold()
                        
                        Link(destination: URL(string:"https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-83954/6E06237C-1B56-4932-A8E1-3A07A3EE03A8/UniversalMac_13.4_22F63_Restore.ipsw")!) {
                            Label("Restore Images", systemImage: "laptopcomputer.and.arrow.down")
                        }
                        
                        Link(destination: URL(string:"https://firebasestorage.googleapis.com/v0/b/jcdevelopment.appspot.com/o/betaProfiles%2FmacOSDeveloperBetaAccessUtility%20-%20JCDev.dmg?alt=media&token=70ef3227-8519-41b5-822f-1da624f49ead")!) {
                            Label("Beta Access Utility", systemImage: "doc.badge.gearshape.fill")
                        }
                    }
                    
                    Section{
                        Text(Image(systemName: "applewatch"))
                            .font(.largeTitle)
                        +
                        Text(" watchOS")
                            .font(.largeTitle)
                            .bold()
                        NavigationLink(destination: PlaceHolderView()) {
                            Label("Beta Profiles (Depreciated)", systemImage: "doc.badge.gearshape.fill")
                        }
                        
                    }
                    
                    Section{
                        Text(Image(systemName: "appletvremote.gen4.fill"))
                            .font(.largeTitle)
                        +
                        Text(Image(systemName: "appletv.fill"))
                            .font(.largeTitle)
                        
                        +
                        Text(" tvOS")
                            .font(.largeTitle)
                            .bold()
                        NavigationLink(destination: PlaceHolderView()) {
                            Label("Beta Profiles (always will work)", systemImage: "doc.badge.gearshape.fill")
                        }
                        
                    }
                }
                .navigationTitle("Downloads")
                .padding(.bottom, 80)
                
            }
            
            
            
        
       
        
    }
    
    struct Downloads_Previews: PreviewProvider {
        static var previews: some View {
            Downloads()
        }
    }
}
