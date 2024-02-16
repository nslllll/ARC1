//
//  Setting.swift
//  ARC1
//
//  Created by Ng Sui Lam on 16/2/2024.
//

import SwiftUI

struct Setting: View {
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section(header: Text("GENERAL SETTINGS")){
                        Text("Account")
                        Text("Privacy")
                        Text("Storage and Data")
                    }
                    Section{
                    
                        HStack {
                        Spacer()
                        Text("Logout")
                    NavigationLink(destination: login()) {
                    }                            
                        Spacer()
                     }
                        .foregroundColor(.red)
                       
                    }
                    

                        
                    }
                .navigationTitle("Settings")
                .accentColor(.blue)
                .listStyle(GroupedListStyle())
                }
            }
            
        }
           
        }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Setting()
        }
    }
