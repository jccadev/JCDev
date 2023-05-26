//
//  ChatSetup.swift
//  JCDev
//
//  Created by Mia Mawby on 21/5/2023.
//

import SwiftUI

struct ChatSetup: View {
    @EnvironmentObject var userAuth: userAuth
    var body: some View {
        NavigationStack{
            VStack{
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
                    .shadow(color: .blue, radius: 15)
                Text("Welcome To DevAI Chat!")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                
                NavigationLink(destination: ChatSetupPage2()) {
                    Text(Image(systemName: "arrow.right.circle.fill"))
                        .foregroundColor(.white)
                    +
                    Text(" Next")
                        .foregroundColor(.white)
                }
                .padding()
                .frame(width: 300, height: 50)
                .background(.blue)
                .cornerRadius(15)
            }
        }
    }
}

struct ChatSetupPage2: View {
    @State var MoreShowing = false
    var body: some View {
        NavigationStack{
            ScrollView{
                Text(Image(systemName: "ellipsis.circle"))
                    .font(.system(size: 100))
                    .foregroundColor(.green)
                    .shadow(color: .green, radius: 15, y: 5)
                
                Text("DevAI Chat helps you with things.")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                
                
                if MoreShowing{
                    Text("Answer questions, provide information and explanations, generate creative writing prompts, help with brainstorming ideas, offer suggestions for activities or hobbies, provide language translation assistance, assist with proofreading and editing, engage in casual conversation and chat, assist with problem-solving and decision-making, generate jokes and entertain with humor, offer motivational quotes or messages, share interesting facts and trivia, provide guidance on learning new subjects or skills, create fictional stories or narratives, offer recommendations for books, movies, or music")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    
                    Button{
                        self.MoreShowing = false
                    } label: {
                        Text("Less")
                            .bold()
                            .foregroundColor(.gray)
                    }
                } else {
                    Text("Answer questions, provide information and explanations, generate creative writing prompts, help with brainstorming ideas, offer suggestions for activities or hobbies...")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    
                    Button{
                        self.MoreShowing = true
                    } label: {
                        Text("More")
                            .bold()
                            .foregroundColor(.gray)
                    }
                    
                    NavigationLink(destination: ChatSetupPage4()) {
                        Text(Image(systemName: "arrow.right.circle.fill"))
                            .foregroundColor(.white)
                        +
                        Text(" Next")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(.blue)
                    .cornerRadius(15)
                }
            }
        }
    }
}

struct ChatSetupPage3: View {
    @AppStorage("APIKey") var APIKey: String = ""
    @State var APIKeyField = ""
    var body: some View {
        NavigationStack {
            VStack{
                Text("API")
                    .font(.system(size: 100, weight: .bold))
                    .shadow(color: .indigo, radius: 15)
                    .foregroundColor(.indigo)
                
                Text("Let's Set Your API Key")
                    .font(.largeTitle.weight(.heavy))
                    .shadow(radius: 10)
                
                if APIKey.isEmpty {
                    HStack{
                        TextField("pk-APIKey", text: $APIKeyField)
                            .textFieldStyle(.roundedBorder)
                        
                        Button{
                            sendAPIKey()
                        } label: {
                            Text("Save")
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))
                        }
                        .frame(height: 5)
                    }
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                    .frame(width: 300)
                } else {
                    VStack{
                        Text("Already Set. If you Want to Set A New Key:")
                            .multilineTextAlignment(.center)
                        
                        Button{
                           deleteAPIKey()
                        } label: {
                            Text("New Key")
                                .foregroundColor(.white)
                                .bold()
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.blue))
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                    .frame(width: 300)
                    
                }
                
                VStack{
                    Link("Visit This Link", destination: URL(string: "https://discord.pawan.krd")!)
                        .bold()
                    
                    
                    Text("Join the discord. Use the command: ")
                    +
                    Text("/key")
                        .bold()
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                .frame(width: 300)
                
                VStack{
                    Text("Please note: if you want to use it on a different wifi network use ")
                        .multilineTextAlignment(.center)
                    
                    Text("/resetip")
                        .bold()
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                .frame(width: 300)
                
                NavigationLink(destination: OpenAINavigation()) {
                    Label("Done!", systemImage: "checkmark.circle.fill")
                        .foregroundColor(.white)
                }
                .padding()
                .frame(width: 300, height: 50)
                .background(.green)
                .cornerRadius(15)
            }
        }
    }
    func sendAPIKey() {
        let key = APIKeyField
        APIKeyField = ""
        UserDefaults.standard.set(key, forKey: "APIKey")
    }
    
    func deleteAPIKey() {
        UserDefaults.standard.set("", forKey: "APIKey")
    }
}

struct ChatSetupPage4: View {
    @State var MoreShowing = false
    @EnvironmentObject var userAuth: userAuth
    
    var body: some View {
        NavigationStack{
            
            ScrollView{
                Text(Image(systemName: "gear.circle"))
                    .font(.system(size: 100))
                    .foregroundColor(.orange)
                    .shadow(color: .orange, radius: 15, y: 5)
                
                Text("DevAI Chat is built on ChatGPT-4")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                
                
                if MoreShowing{
                    VStack{
                        Text("ChatGPT-4, the fourth iteration of OpenAI's language model, has not only been a significant advancement in conversational AI but has also found practical applications in platforms like DevAI Chat. With its enhanced capabilities and improved performance, ChatGPT-4 offers developers a powerful tool to create engaging and dynamic conversational experiences. One of the standout features of ChatGPT-4 is its ability to generate human-like responses. Trained on extensive and diverse text data, the model has acquired a deep understanding of human language, allowing it to provide more coherent and contextually appropriate responses. This makes it an ideal choice for integration into platforms like DevAI Chat, where natural and engaging conversations are essential. OpenAI has been diligent in addressing the limitations observed in previous iterations of ChatGPT, and ChatGPT-4 is no exception. Through a combination of rule-based filters and reinforcement learning from human feedback, OpenAI has made significant strides in mitigating issues related to providing incorrect or biased information. While the model is not infallible, these measures ensure that it delivers more reliable and accurate responses to users. ChatGPT-4's improved handling of ambiguous queries is another significant advancement. The model can ask clarifying questions to better understand user intent, enabling it to deliver more relevant and precise responses. This ability greatly enhances the user experience in platforms like DevAI Chat, where users may pose open-ended or contextually complex queries. OpenAI has also focused on making ChatGPT-4 more customizable and controllable, which is particularly valuable for developers. Through explicit instruction, developers can easily define preferences or desired outcomes, allowing for personalized conversations tailored to specific use cases. This customization aspect enhances the integration of ChatGPT-4 into platforms like DevAI Chat, enabling developers to create unique and tailored conversational experiences for their users. Furthermore, OpenAI's introduction of the ChatGPTAPI facilitates seamless integration of ChatGPT-4 into developer applications and services. This API allows developers to harness the capabilities of ChatGPT-4 within the DevAI Chat platform, expanding its potential applications and accessibility. Developers can now build chatbots, virtual characters, and interactive conversational agents using ChatGPT-4 as a foundational component. OpenAI remains committed to ethical considerations when deploying AI systems, and this is reflected in ChatGPT-4. Efforts to minimize biased behavior and reduce the risk of generating harmful or inappropriate content have been prioritized. OpenAI actively seeks user feedback to improve their systems and address any ethical concerns that may arise, ensuring that platforms like DevAI Chat provide a safe and responsible conversational environment. In conclusion, ChatGPT-4's integration into platforms like DevAI Chat brings about exciting possibilities for developers. Its human-like response generation, improved handling of queries, customization options, and accessibility through the ChatGPT API make it a valuable tool for creating engaging and dynamic conversational experiences. As OpenAI continues to refine and advance ChatGPT models, we can expect even more sophisticated and useful conversational AI applications in the future.")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                        
                        
                        Button{
                            self.MoreShowing = false
                        } label: {
                            Text("Less")
                                .bold()
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.bottom, 80)
                } else {
                    Text("ChatGPT-4, the fourth iteration of OpenAI's language model, has not only been a significant advancement in conversational AI but has also found practical applications in platforms like DevAI Chat. With its enhanced capabilities and improved performance, ChatGPT-4 offers developers a powerful tool to create engaging and dynamic conversational experiences. One of the standout features of ChatGPT-4 is its ability to generate human-like responses...")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    
                    Button{
                        self.MoreShowing = true
                    } label: {
                        Text("More")
                            .bold()
                            .foregroundColor(.gray)
                    }
                    NavigationLink(destination: ChatSetupPage3()) {
                        Label("Done!", systemImage: "checkmark.circle.fill")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(.green)
                    .cornerRadius(15)
                    
                   
                }
            }
        }
    }
    func saveTextToFile(text: String, fileName: String) {
        if let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = directoryURL.appendingPathComponent(fileName)
            
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
                print("Text file saved successfully.")
            } catch {
                print("Error while saving text file: \(error.localizedDescription)")
            }
        }
    }
    
    func readTextFromFile(fileName: String) -> String? {
        if let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = directoryURL.appendingPathComponent(fileName)
            
            do {
                let text = try String(contentsOf: fileURL, encoding: .utf8)
                return text
            } catch {
                print("Error while reading text file: \(error.localizedDescription)")
            }
        }
        
        return nil
    }

}


struct ChatSetup_Previews: PreviewProvider {
    static var previews: some View {
        ChatSetup()
    }
}
