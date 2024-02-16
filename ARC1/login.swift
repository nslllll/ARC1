//
//  login.swift
//  ARC1
//
//  Created by Ng Sui Lam on 16/1/2024.
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
    @StateObject var model = BiometricModel()
    
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
                    
                   
                    NavigationLink(destination: home(), isActive: $showingLoginScreen) {
                        Text("Login")
                    }
                    .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.green)
                        .cornerRadius(10)
    

                    Button(action: {
                        model.evaluatePolicy()
                    }, label: {
                        Image(systemName: "faceid")
                            .resizable()
                            .foregroundColor(.green)
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                            .padding( )
                            
                    })
                
                    if model.isError == true {
                        Text("\(model.errorMessage)")
                    }
                    Button("Forgot Passowrd?"){}
                                    .font(.callout)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.green)
                    HStack(spacing: 6){
                    Text("Don't have an account?")
                            .foregroundStyle(.gray)
                    Button("SignUp"){}
                            .foregroundColor(.green)
                                    }
                    .padding( )
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
            
        }.toolbar(.hidden, for: .tabBar)
    }
    
}
struct Home: View {
    var body: some View {
        VStack {
        }
    }
}

struct login_Previews: PreviewProvider {
    static var previews: some View {
        login()
    }
}
