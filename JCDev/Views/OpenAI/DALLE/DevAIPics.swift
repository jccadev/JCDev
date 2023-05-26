import SwiftUI
import RiveRuntime
import Alamofire
import AlamofireImage
import MobileCoreServices
import UniformTypeIdentifiers

struct DevAIPics: View {
    @EnvironmentObject var userAuth: userAuth
    @State private var prompt = ""
    @State private var generatedImage: UIImage?
    @State var loadingTrigger = false
    @State var dalleAPIKey = "pk-BrmWJRHVXkbkpwUvUBMhquisPXTKdHfWZhSsNuIAYiHCReuV"
    @State var boxShows = true
    @State var isImageGenerated = false
    @AppStorage("APIKey") var APIKey: String = ""
    
    struct APIResponse: Codable {
        let data: [ImageData]
        
        struct ImageData: Codable {
            let url: String
        }
    }
    
    var body: some View {
        ZStack{
            if userAuth.animationvar {
                RiveViewModel(fileName: "shapeslogin").view()
                    .blur(radius: 30)
                    .ignoresSafeArea()
            } else {
                
            }
            if APIKey.isEmpty {
                ChatSetupPage3()
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25))
            } else {
                VStack {
                    
                    if let image = generatedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(25)
                            .padding()
                        
                        Button {
                            shareImage(image)
                        } label: {
                            Text(Image(systemName: "square.and.arrow.up"))
                            +
                            Text(" Share")
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                        .bold()
                    }
                    
                    VStack{
                        if let image = generatedImage {
                        } else {
                            Spacer(minLength: 420)
                        }
                        if boxShows {
                            HStack{
                                TextField("Type a message...", text: $prompt)
                                
                                if prompt.isEmpty {
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .background(Color.gray)
                                        .cornerRadius(7)
                                } else {
                                    Button{
                                        loadingTrigger = true
                                        sendMessage()
                                        boxShows = false
                                    } label: {
                                        Image(systemName: "paperplane.fill")
                                            .foregroundColor(.white)
                                    }
                                    .padding(5)
                                    .background(Color.blue)
                                    .cornerRadius(7)
                                }
                                
                            }
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .padding(.bottom, 100)
                            .frame(width: 360)
                        } else {
                            
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .padding()
        .navigationBarTitle("Pics")
        .onAppear {
            isImageGenerated = generatedImage != nil // Set the Boolean variable based on the generatedImage value
        }
        if loadingTrigger {
                ChatLoadingView()
                .padding(.bottom, 100)
        }
    }
    
    func shareImage(_ image: UIImage) {
            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = scene.windows.first else {
                return
            }
            
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            
            // Customize the share title
            activityViewController.setValue("AI Generated Image", forKey: "subject")
            
            // Add additional text with file format and size
            
            
            // iPad-specific presentation handling
            if let popoverPresentationController = activityViewController.popoverPresentationController {
                popoverPresentationController.sourceView = window.rootViewController?.view
                popoverPresentationController.sourceRect = CGRect(x: window.frame.midX, y: window.frame.midY, width: 0, height: 0)
                popoverPresentationController.permittedArrowDirections = []
            }
            
            window.rootViewController?.present(activityViewController, animated: true, completion: nil)
        }
        
    
        
    
    private func sendMessage() {
        guard !prompt.isEmpty else { return }
        
        let message = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
        prompt = ""
        
        let apiURL = URL(string: "https://api.pawan.krd/v1/images/generations")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(APIKey)",
            "Content-Type": "application/json"
        ]
        
        let parameters: [String: Any] = [
            "prompt": message,
            "n": 1,
            "size": "1024x1024"
        ]
        
        AF.request(apiURL,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
            .validate()
            .responseDecodable(of: APIResponse.self) { response in
                switch response.result {
                case .success(let value):
                    print("Response: \(value)")
                    
                    if let firstImageData = value.data.first,
                       let imageURL = URL(string: firstImageData.url) {
                        AF.request(imageURL).responseImage { response in
                            switch response.result {
                            case .success(let image):
                                DispatchQueue.main.async {
                                    self.boxShows = true
                                    self.generatedImage = image
                                    self.loadingTrigger = false
                                }
                            case .failure(let error):
                                print("Error fetching image: \(error)")
                                DispatchQueue.main.async {
                                    self.boxShows = true
                                    self.loadingTrigger = false
                                }
                            }
                        }
                    } else {
                        print("Error: Invalid response format.")
                        DispatchQueue.main.async {
                            self.boxShows = true
                            self.loadingTrigger = false
                        }
                    }
                    
                case .failure(let error):
                    print("Error: \(error)")
                    DispatchQueue.main.async {
                        self.boxShows = true
                        self.loadingTrigger = false
                    }
                }
            }
    }
}

struct DevAIPics_Previews: PreviewProvider {
    static var previews: some View {
        DevAIPics()
    }
}

