import SwiftUI
import UIKit
import RiveRuntime
import Alamofire
import ChatGPTSwift

struct ChatView: View {
    let greetings = [
        "Hello!",
        "Hi there!",
        "G'day!",
        "Good morning!",
        "Good afternoon!",
        "Good evening!",
        "Hey!",
        "Salutations!",
        "Howdy!",
        "What's up?",
        "Nice to meet you!",
        "Greetings!",
        "Wishing you a wonderful day!",
        "Hope you're doing well!",
        "Hey, how are you?",
        "Welcome!",
        "Hiya!",
        "Bonjour!",
        "Ciao!",
        "Namaste!"
        ]
    
    let restartedGreetings = [
        "Wow, a new chat",
        "FUCK YOU BITCH WHY RESTART",
        "Its always great to start over",
        "I like starting on a new slate.",
        "WHY DID YOU START OVER BRO!?",
        "Welcome abo... Wakes Up",
        "New chat, new possibilities!",
                "Let's chat!",
                "Starting over, huh? Fine.",
                "Back again, huh?",
                "Can't stay away, can you?",
                "Oh, you decided to return?",
                "Restarting the chat, but can't restart life.",
                "Well, look who's back!",
                "Restarting the chat? Hope it goes better this time!",
                "You again? What happened now?",
                "Alright, fresh start. Let's make it count.",
                "Starting over with high hopes, I see!",
                "Here we go again...",
                "Restarting the chat, but can't escape the past.",
                "Welcome back! Ready for round two?",
                "Restarting? I hope you're more committed this time!",
                "Back from the dead, are we?",
                "Restarting the chat? Don't mess it up this time!",
                "Oh, it's you again. What's the plan this time?",
                "Starting over, but will it make a difference?",
                "Restarting the chat, like pressing the reset button.",
                "You just can't resist restarting, can you?"
    ]

    @EnvironmentObject var userAuth: userAuth
    @State private var messages: [Message] = []
    @State private var userInput: String = ""
    @Environment(\.colorScheme) var colorScheme
    @State var loadingTrigger = false
    @State var changedText = ""
    @AppStorage("APIKey") var APIKey = ""
    
    
    struct Message: Identifiable {
        let id = UUID()
        let content: String
        let role: Role
        
        enum Role {
            case user
            case assistant
        }
    }
    
    
    var body: some View {
        ZStack{
            if userAuth.animationvar {
                RiveViewModel(fileName: "shapes").view()
                    .blur(radius: 30)
                    .ignoresSafeArea()
            } else {
                
            }
            if APIKey.isEmpty {
                ChatSetupPage3()
            } else {
                VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(messages) { message in
                                if isCodeSnippet(message.content) {
                                    Text(changedText)
                                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                                        .padding()
                                        .foregroundColor(message.role == .assistant ? colorScheme == .light ? Color.black : Color.white : Color.white)
                                        .background(message.role == .user ? Color.blue : Color.black)
                                        .cornerRadius(15)
                                        .frame(maxWidth: .infinity, alignment: message.role == .assistant ? .leading : .trailing)
                                        .padding(.leading, 10)
                                        .padding(.trailing, 10)
                                        .onTapGesture {
                                            UIPasteboard.general.string = message.content
                                        }
                                } else {
                                    Text(message.content)
                                        .padding()
                                        .foregroundColor(message.role == .assistant ? colorScheme == .light ? Color.black : Color.white : Color.white)
                                        .background(message.role == .user ? Color.blue : colorScheme == .light ? Color.gray.opacity(0.1) : Color.gray.opacity(0.5))
                                        .cornerRadius(15)
                                        .frame(maxWidth: .infinity, alignment: message.role == .assistant ? .leading : .trailing)
                                        .padding(.leading, 10)
                                        .padding(.trailing, 10)
                                        .onTapGesture {
                                            UIPasteboard.general.string = message.content
                                        }
                                }
                            }
                        }
                    }
                    
                    
                    
                    if messages.count > 1 {
                        VStack{
                            Button {
                                self.loadingTrigger = false
                                self.messages = []
                                self.messages.append(Message(content: restartedGreetings.randomElement() ?? "", role: .assistant))
                            } label: {
                                Text(Image(systemName: "xmark.app.fill"))
                                    .foregroundColor(Color.white)
                                +
                                Text(" Clear")
                                    .foregroundColor(Color.white)
                                
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15, style: .continuous).foregroundColor(.blue))
                        }
                        .padding(.bottom, 5)
                        
                    } else {
                        VStack{
                            
                            Text(Image(systemName: "xmark.app.fill"))
                                .foregroundColor(Color.white)
                            +
                            Text(" Clear")
                                .foregroundColor(Color.white)
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15, style: .continuous).foregroundColor(.gray))
                        .padding(.bottom, 5)
                    }
                    
                    VStack{
                        Text("To copy the response, press on the text")
                            .font(.system(size: 10))
                    }
                    
                    HStack {
                        TextField("Type a message...", text: $userInput)
                        
                        if userInput.isEmpty {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color.gray)
                                .cornerRadius(7)
                        } else {
                            Button{
                                self.loadingTrigger = true
                                sendMessage()
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
                }
            }
        }
        .overlay{
            if loadingTrigger {
                ChatLoadingView()
            } else {
                
            }
        }
        .navigationBarTitle("Chat")
        .onAppear {
            self.messages.append(Message(content: greetings.randomElement() ?? "", role: .assistant))
        }
    }
    
    func isCodeSnippet(_ text: String) -> Bool {
        return text.contains("\n\n```")
    }


    
    private func sendMessage() {
        guard !userInput.isEmpty else { return }
        
        let message = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
        messages.append(Message(content: message, role: .user))
        userInput = ""
        
        // Prepare the messages array for API request
        var chatMessages: [[String: String]] = []
        
        // Add the system message
        chatMessages.append(["role": "system", "content": "You are a helpful assistant."])
        
        // Add the assistant messages from previous interactions
        for message in messages {
            let role = (message.role == .user) ? "user" : "assistant"
            chatMessages.append(["role": role, "content": message.content])
        }
        
        // Create the request parameters
        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": chatMessages
        ]
        
        // Create the API request
        // Convert parameters to JSON data
           guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
               print("Error: Failed to convert parameters to JSON data.")
               return
           }
           
           // Create the API request
           guard let apiURL = URL(string: "https://api.pawan.krd/v1/chat/completions") else {
               print("Error: Invalid API URL.")
               return
           }
           
           var request = URLRequest(url: apiURL)
           request.httpMethod = "POST"
           request.setValue("Bearer \(APIKey)", forHTTPHeaderField: "Authorization")
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           request.httpBody = jsonData
           
           URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Error: \(error)")
                   return
               }
               
               guard let data = data else {
                   print("Error: No data received.")
                   return
               }
               
               if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                   print("Response JSON: \(responseJSON)")
                   
                   if let errorMessage = responseJSON["error"] as? [String: Any], let message = errorMessage["message"] as? String {
                       print("Error: \(message)")
                       return
                   }
                   
                   if let choices = responseJSON["choices"] as? [[String: Any]], let chatResponse = choices.last?["message"] as? [String: String], let text = chatResponse["content"] {
                       DispatchQueue.main.async {
                           self.messages.append(Message(content: text, role: .assistant))
                           self.loadingTrigger = false
                       }
                   } else {
                       print("Error: Invalid response format.")
                       self.loadingTrigger = false
                   }
               } else {
                   print("Error: Failed to parse JSON response.")
                   self.loadingTrigger = false
               }
           }.resume()
    }
    


}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

