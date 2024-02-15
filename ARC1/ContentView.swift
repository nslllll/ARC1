//
//  ContentView.swift
//  ARC1
//
//  Created by Ng Sui Lam on 29/1/2024.
//

import SwiftUI
import RealityKit


struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}
struct ARViewContainer:  UIViewRepresentable{
    func makeUIView(context: Context) -> some UIView {
        let arView = ARView(frame: .zero)
        
        let clothes = try! Experience.loadBox()
        
        return arView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    
    struct ContentView_Previews : PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

