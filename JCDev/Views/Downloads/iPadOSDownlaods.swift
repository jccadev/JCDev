import SwiftUI
import RiveRuntime

var Weburl2 = ""

struct iPadOSDownloads: View {
    let targetDate: Date = {
            var calendar = Calendar.current
            let components = DateComponents(year: 2023, month: 6, day: 6, hour: 19, minute: 0)
            return calendar.date(from: components)!
        }()
    
    @State var loadingTrigger = false
    @EnvironmentObject var userAuth: userAuth
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack {
            if Date() >= targetDate{
                VStack{
                    Text("Preparing For iOS 17")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                    List{
                        Section{
                            ListItemView(title: "11-in. iPad Pro (4th generation), 12.9-in. iPad Pro (6th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85498/2CAAD64A-DA8B-4017-8B3E-5971793AF415/iPad14,3,iPad14,4,iPad14,5,iPad14,6_16.5_20F66_Restore.ipsw", version: "20F66")
                            ListItemView(title: "10.2-in. iPad (10th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85238/2F412DA1-2E10-420D-9942-E7C6C3C7AD07/iPad_Fall_2022_16.5_20F66_Restore.ipsw", version: "20F66")
                            ListItemView(title: "iPad Air (5th Generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85625/80ACA4C7-8683-41C6-BD04-520607D8F76B/iPad_Spring_2022_16.5_20F66_Restore.ipsw", version: "20F66")
                            
                            ListItemView(title: "iPad mini (6th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85162/D4C96AC6-95E2-41B3-80D0-662337E296AD/iPad_Fall_2021_16.5_20F66_Restore.ipsw", version: "20F66")
                        }
                        
                        Section{
                            ListItemView(title: "iPad (9th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85559/284E843B-CC5A-4EAD-9013-B56D91713ED7/iPad_10.2_2021_16.5_20F66_Restore.ipsw", version: "20F66")
                            ListItemView(title: "11-in. iPad Pro (3rd generation), 12.9-in. iPad Pro (5th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85049/E7F630DF-EE6F-49E0-AFCA-2246F0D78041/iPad_Pro_Spring_2021_16.5_20F66_Restore.ipsw", version: "20F66")
                            ListItemView(title: "iPad Air (4th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85030/B6A7834D-C169-4297-9ABE-0A831F54D9BC/iPad_Fall_2020_16.5_20F66_Restore.ipsw", version: "20F66")
                        }
                        
                        Section{
                            ListItemView(title: "10.2-in. iPad (8th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-84955/9714295D-6AED-4024-A539-8BF13769F3F9/iPad_10.2_2020_16.5_20F66_Restore.ipsw", version: "20F66")
                            ListItemView(title: "11-in. iPad Pro (1st and 2nd generations), 12.9-in. iPad Pro (3rd and 4th generations)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85616/3FE087AF-4283-476F-B90C-98352C543C97/iPad_Pro_A12X_A12Z_16.5_20F66_Restore.ipsw", version: "20F66")
                        }
                        
                        
                        ListItemView(title: "10.5-in. iPad Pro (1st generation), 12.9-in. iPad Pro (2nd generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85273/20D959A6-6A24-4E16-886F-90178C266CF9/iPad_Pro_HFR_16.5_20F66_Restore.ipsw", version: "20F66")
                        ListItemView(title: "iPad (5th generation), iPad (6th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85178/78BCB6E3-2808-4BB6-A86C-2EFB9A4826F0/iPad_64bit_TouchID_ASTC_16.5_20F66_Restore.ipsw", version: "20F66")
                        ListItemView(title: "iPad mini (5th generation), iPad Air (3rd generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85323/1C25C1EC-DE75-42D0-BC1E-E8E105336E96/iPad_Spring_2019_16.5_20F66_Restore.ipsw", version: "20F66")
                        ListItemView(title: "10.2-in. iPad (7th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85073/CCE27BB2-DF15-4DA8-80E0-C9B885DBA725/iPad_10.2_16.5_20F66_Restore.ipsw", version: "20F66")
                        ListItemView(title: "9.7-in. iPad Pro (1st generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-84945/82B5AFDF-883D-4759-8CE7-BD852E01EA2F/iPadPro_9.7_16.5_20F66_Restore.ipsw", version: "20F66")
                        ListItemView(title: "12.9-in. iPad Pro (1st generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85575/DD179E9F-A2F1-410F-A26E-456CADCEA58F/iPadPro_12.9_16.5_20F66_Restore.ipsw", version: "20F66")
                        
                    }
                }
                .onTapGesture {
                    self.loadingTrigger = true
                }
                
                .navigationTitle("iPadOS Downloads")
            } else {
                List{
                    Section{
                        ListItemView(title: "11-in. iPad Pro (4th generation), 12.9-in. iPad Pro (6th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85498/2CAAD64A-DA8B-4017-8B3E-5971793AF415/iPad14,3,iPad14,4,iPad14,5,iPad14,6_16.5_20F66_Restore.ipsw", version: "20F66")
                        ListItemView(title: "10.2-in. iPad (10th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85238/2F412DA1-2E10-420D-9942-E7C6C3C7AD07/iPad_Fall_2022_16.5_20F66_Restore.ipsw", version: "20F66")
                        ListItemView(title: "iPad Air (5th Generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85625/80ACA4C7-8683-41C6-BD04-520607D8F76B/iPad_Spring_2022_16.5_20F66_Restore.ipsw", version: "20F66")
                        
                        ListItemView(title: "iPad mini (6th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85162/D4C96AC6-95E2-41B3-80D0-662337E296AD/iPad_Fall_2021_16.5_20F66_Restore.ipsw", version: "20F66")
                    }
                    
                    Section{
                        ListItemView(title: "iPad (9th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85559/284E843B-CC5A-4EAD-9013-B56D91713ED7/iPad_10.2_2021_16.5_20F66_Restore.ipsw", version: "20F66")
                        ListItemView(title: "11-in. iPad Pro (3rd generation), 12.9-in. iPad Pro (5th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85049/E7F630DF-EE6F-49E0-AFCA-2246F0D78041/iPad_Pro_Spring_2021_16.5_20F66_Restore.ipsw", version: "20F66")
                        ListItemView(title: "iPad Air (4th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85030/B6A7834D-C169-4297-9ABE-0A831F54D9BC/iPad_Fall_2020_16.5_20F66_Restore.ipsw", version: "20F66")
                    }
                    
                    Section{
                        ListItemView(title: "10.2-in. iPad (8th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-84955/9714295D-6AED-4024-A539-8BF13769F3F9/iPad_10.2_2020_16.5_20F66_Restore.ipsw", version: "20F66")
                        ListItemView(title: "11-in. iPad Pro (1st and 2nd generations), 12.9-in. iPad Pro (3rd and 4th generations)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85616/3FE087AF-4283-476F-B90C-98352C543C97/iPad_Pro_A12X_A12Z_16.5_20F66_Restore.ipsw", version: "20F66")
                    }
                    
                    
                        ListItemView(title: "10.5-in. iPad Pro (1st generation), 12.9-in. iPad Pro (2nd generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85273/20D959A6-6A24-4E16-886F-90178C266CF9/iPad_Pro_HFR_16.5_20F66_Restore.ipsw", version: "20F66")
                        ListItemView(title: "iPad (5th generation), iPad (6th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85178/78BCB6E3-2808-4BB6-A86C-2EFB9A4826F0/iPad_64bit_TouchID_ASTC_16.5_20F66_Restore.ipsw", version: "20F66")
                        ListItemView(title: "iPad mini (5th generation), iPad Air (3rd generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85323/1C25C1EC-DE75-42D0-BC1E-E8E105336E96/iPad_Spring_2019_16.5_20F66_Restore.ipsw", version: "20F66")
                        ListItemView(title: "10.2-in. iPad (7th generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85073/CCE27BB2-DF15-4DA8-80E0-C9B885DBA725/iPad_10.2_16.5_20F66_Restore.ipsw", version: "20F66")
                        ListItemView(title: "9.7-in. iPad Pro (1st generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-84945/82B5AFDF-883D-4759-8CE7-BD852E01EA2F/iPadPro_9.7_16.5_20F66_Restore.ipsw", version: "20F66")
                        ListItemView(title: "12.9-in. iPad Pro (1st generation)", url: "https://updates.cdn-apple.com/2023SpringFCS/fullrestores/032-85575/DD179E9F-A2F1-410F-A26E-456CADCEA58F/iPadPro_12.9_16.5_20F66_Restore.ipsw", version: "20F66")
                    
                }
                .blur(radius: 5)
                .overlay{
                    ZStack{
                        Rectangle()
                            .ignoresSafeArea()
                            .opacity(0.2)
                            .foregroundColor(colorScheme == .light ? .white : .black)
                        
                        VStack{
                            Text(Image(systemName: "gearshape.2.fill"))
                                .font(.system(size: 100))
                            Text("Under Maintenance")
                                .font(.largeTitle)
                                .fontWeight(.black)
                            Text("You will be able to access Downloads on: \(targetDate, formatter: dateFormatter)")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                        }
                        
                    }
                }
            }
            
            
        }
        
        
        
        
    }
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy 'at' h:mm a"
            return formatter
        }()
}



import SwiftUI

struct ListItemView: View {
    let title: String
    let url: String
    let version: String
    @EnvironmentObject var userAuth: userAuth
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Text(url)
                .font(.subheadline)
            Button(action: {
                Weburl2 = url
                userAuth.WebOn()
            }) {
                Text("iPadOS 16.5 RC 2")
                    .bold()
                    .foregroundColor(.gray)
            }
        }
        
    }
    
    private func downloadFile() {
        
        guard let fileURL = URL(string: url) else {
            print("Invalid URL")
            return
        }
        

        let downloadTask = URLSession.shared.downloadTask(with: fileURL) { localURL, _, error in
            guard let localURL = localURL else {
                if let error = error {
                    print("Download error: \(error.localizedDescription)")
                }
                return
            }

            let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
            let temporaryFileURL = temporaryDirectoryURL.appendingPathComponent(fileURL.lastPathComponent)

            do {
                try FileManager.default.moveItem(at: localURL, to: temporaryFileURL)
                DispatchQueue.main.async {
                    shareFile(with: temporaryFileURL)
                }
            } catch {
                print("File move error: \(error.localizedDescription)")
            }
        }

        downloadTask.resume()
    }

    func shareFile(with fileURL: URL) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else {
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        window.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }



    
}



// This is just a placeholder preview to demonstrate the layout
struct iPadOSDownloads_Previews: PreviewProvider {
    static var previews: some View {
        iPadOSDownloads()
    }
}


