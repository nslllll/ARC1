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
                Image(systemName: "doc.badge.plus")
                    Text("Create")
                    }.tag(1)
            }
            location().tabItem({
                            Image(systemName: "location.circle")
                            Text("Location")
                        }).tag(2)
            Setting().tabItem({
                            Image(systemName: "gearshape.fill")
                            Text("Settings")
                        }).tag(3)
        }
        .toolbar(.visible, for: .tabBar)
    }
}
struct home_Previews : PreviewProvider {
    static var previews: some View {
        home()
    }
}
