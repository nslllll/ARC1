//
//  login.swift
//  ARC1
//
//  Created by Ng Sui Lam on 16/2/2024.
//

import SwiftUI
import LocalAuthentication

struct login: View {
    @State private var username : String = ""
    @State private var password : String = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    var body: some View {
        NavigationView{
            ZStack {
                Color.green.ignoresSafeArea()
                Circle()
                    .scale(1.9)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.2)
                    .foregroundColor(.white)
                VStack{
                    Text("Clothing Design")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width:300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    Button("Login"){
                        autherticateUser(username: username, password: password)
                        button.addTarget(self, action: #selector(TapButton))
                    }
                   
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: home(), isActive: $showingLoginScreen){
                        EmptyView()
                        }
                    }
                    }
                }
        .navigationBarHidden(true)
        }
    func autherticateUser(username:  String, password: String){
        if username.lowercased() == "asd123"{
            wrongUsername = 0
            if password.lowercased() ==  "abc123"{
                wrongPassword = 0
                showingLoginScreen = true
            }else {
                wrongPassword = 2
            }
        }else{
            wrongUsername = 2
        }
        }
    func TapButton(){
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,error: &error){
            let reason = "Please authorize with touchID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,localizedReason: reason){[weak self] success, error in
                guard succes, error == nill else{
                    return
                }
                
            }
            
        }
        else{
            
        }
    }
    }
        
    
struct login_Previews: PreviewProvider {
    static var previews: some View {
        login()
    }
}
