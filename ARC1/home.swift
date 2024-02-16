//
//  home.swift
//  ARC1
//
//  Created by Ng Sui Lam on 16/2/2024.
//

import SwiftUI

struct home: View {
    var body: some View {
        TabView {
            ContentView().tabItem{
                NavigationLink(destination: ContentView()){
                    Image(systemName: "hanger")}.tag(1)
            }
            location().tabItem{
                NavigationLink(destination: location()){
                    Image(systemName: "hanger")}.tag(1)
            }
            
        }
    }
}
