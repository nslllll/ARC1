//
//  login.swift
//  ARC1
//
//  Created by Ng Sui Lam on 16/2/2024.
//

import SwiftUI
import LocalAuthentication

struct login: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.green.ignoresSafeArea()
                Circle()
                    .scale(1.9)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.2)
                    .foregroundColor(.white)
                VStack {
                    Text("Clothing Design")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(Color.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(Color.red, width: CGFloat(wrongPassword))
                    
                    Button("Login") {
                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: Home(), isActive: $showingLoginScreen) {
                        EmptyView()
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Failed to Authenticate"),
                message: Text("Please try again."),
                dismissButton: .cancel()
            )
        }
    }
    
    func authenticateUser(username: String, password: String) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authorize with Face ID or Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        showingLoginScreen = true
                    } else {
                        showingAlert = true
                    }
                }
            }
        } else {
            showingAlert = true
        }
    }
}

struct Home: View {
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
                .bold()
                .padding()
            Spacer()
        }
    }
}

struct login_Previews: PreviewProvider {
    static var previews: some View {
        login()
    }
}	
