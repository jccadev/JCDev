import SwiftUI
import RiveRuntime

struct DownloadButton: View {
    let modelName: String
    let url: URL
    @State var BuildNumber = "20F65"
    var body: some View {
        Button(action: {
            // Open the URL when the button is tapped
            UIApplication.shared.open(url)
        }) {
            Text(modelName)
            
            Text(BuildNumber)
        }
        .frame(width: 330)
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
    }
}

struct DownloadsPage: View {
    let supportedModels: [(modelName: String, url: URL)] = [
        // Add URLs and model names for iPhone models that support iOS 15
        ("iPhone SE (2nd Generation)", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38781/22DEB948-D0BB-43D8-BACD-A123B8B85BE4/iPhone12,8_16.5_20F65_Restore.ipsw")!),
        ("iPhone 8", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38897/9B41F7BC-F1B5-4259-B261-35D0BE9D8897/iPhone_4.7_P3_16.5_20F65_Restore.ipsw")!),
        ("iPhone 8 Plus", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38905/C2FA5484-F9BE-4950-83B4-CA9FC987C641/iPhone_5.5_P3_16.5_20F65_Restore.ipsw")!),
        ("iPhone X", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38859/0B14FE39-D6A2-4FB8-A699-99B4DB7DB202/iPhone10,3,iPhone10,6_16.5_20F65_Restore.ipsw")!),
        ("iPhone XR", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38924/DF6CF5FB-3C23-43CD-8E51-5976B36583CD/iPhone11,8_16.5_20F65_Restore.ipsw")!),
        ("iPhone XS, XS Max", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38801/13C78710-8403-43C9-8739-769134D8A452/iPhone11,2,iPhone11,4,iPhone11,6_16.5_20F65_Restore.ipsw")!),
        ("iPhone 11", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38774/F189B3E1-93F3-4ECC-AEC9-615FDBD022A2/iPhone12,1_16.5_20F65_Restore.ipsw")!),
        ("iPhone 11 Pro, 11 Pro Max", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38995/8EA561FF-EA4D-46EA-8889-1939CDAC1D29/iPhone12,3,iPhone12,5_16.5_20F65_Restore.ipsw")!),
        ("iPhone 12 mini", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38888/1B3B1642-D761-4AAA-A459-3D0843DAF5A5/iPhone13,1_16.5_20F65_Restore.ipsw")!),
        ("iPhone 12 Pro Max", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38809/7F3B0A3E-9083-4A05-A59F-FA68DE100F2F/iPhone13,4_16.5_20F65_Restore.ipsw")!),
        ("iPhone 12, 12 Pro", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38984/B1CE4C84-1B1E-46BF-9DAE-ECFBCE5DF4AC/iPhone13,2,iPhone13,3_16.5_20F65_Restore.ipsw")!),
        ("iPhone 13 mini", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38769/29DB873D-EE5B-433D-B093-B04658C8F44F/iPhone14,4_16.5_20F65_Restore.ipsw")!),
        ("iPhone 13 Pro Max", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38811/ED031818-C25A-4E87-B3E2-34C57D1A6D4D/iPhone14,3_16.5_20F65_Restore.ipsw")!),
        ("iPhone 13 Pro", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38972/A0AD6692-6600-4B79-8E4D-C05746912A46/iPhone14,2_16.5_20F65_Restore.ipsw")!),
        ("iPhone 13", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38985/9B72225C-F639-4223-ABA6-C3C6A73BE2C1/iPhone14,5_16.5_20F65_Restore.ipsw")!),
        ("iPhone SE (3rd Generation)", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38929/C579123E-1140-4DAB-9DF1-60F1C8DE0722/iPhone14,6_16.5_20F65_Restore.ipsw")!),
        ("iPhone 14", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38775/DC981BD8-8383-491A-83A0-20B30CAD4809/iPhone14,7_16.5_20F65_Restore.ipsw")!),
        ("iPhone 14 Plus", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38969/C8B709BC-FF1F-480B-BE19-0458F5EEE359/iPhone14,8_16.5_20F65_Restore.ipsw")!),
        ("iPhone 14 Pro", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38939/281966EB-F6DB-4B15-8D96-69EA3C78FD0E/iPhone15,2_16.5_20F65_Restore.ipsw")!),
        ("iPhone 14 Pro Max", URL(string: "https://updates.cdn-apple.com/2023SpringSeed/fullrestores/032-38849/671E0309-61DA-421A-AB50-44E3B695FBF8/iPhone15,3_16.5_20F65_Restore.ipsw")!),
        // Add more iPhone models and URLs as needed
    ]
    
    var body: some View {
        ScrollView {
            Spacer()
            ForEach(supportedModels, id: \.modelName) { model in
                DownloadButton(modelName: model.modelName, url: model.url)
                    .padding(.bottom, 10)
            }
            Spacer()
        }
    }
}

struct iOSDownloads: View {
    @EnvironmentObject var userAuth: userAuth
    @State var BuildNumber = "20F65"
    @State var Version = "iOS 16.5 RC"
    var body: some View {
        NavigationStack{
            ZStack {
                if userAuth.animationvar {
                    RiveViewModel(fileName: "shapes").view()
                        .blur(radius: 30)
                        .ignoresSafeArea()
                } else {
                    LinearGradient(colors: [.cyan.opacity(0.7), .indigo.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea()
                }
                
                DownloadsPage()
                    .navigationTitle(Version)
                    .padding(.bottom, 90)
            }
            
        }
        
    }
}

// This is just a placeholder preview to demonstrate the layout
struct iOSDownloads_Previews: PreviewProvider {
    static var previews: some View {
        iOSDownloads()
    }
}

