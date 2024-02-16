//
//  ContentView.swift
//  ARC1
//
//  Created by Ng Sui Lam on 29/1/2024.
//

import SwiftUI
import RealityKit
import PencilKit

struct ContentView: View {
    @State private var isShowingDrawView = false
    
    var body: some View {
        ZStack {
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Button(action: {
                    isShowingDrawView = true
                }) {
                    Circle()
                        .foregroundColor(.blue)
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: "scribble")
                        .imageScale(.large)
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
        .sheet(isPresented: $isShowingDrawView) {
            DrawView()
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let clothes = try! Experience.loadBox()
        arView.scene.anchors.append(clothes)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
}

struct DrawView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var selectedColor: Color = .black
    
    var body: some View {
        NavigationView {
            ZStack {
                DrawingView(canvasView: $viewModel.canvasView, selectedColor: $selectedColor)
                
                VStack {
                    HStack(spacing: 10) {
                        Spacer()
                        
                        ColorPicker("Color", selection: $selectedColor)
                            .labelsHidden()
                        
                        Button(action: {
                            viewModel.canvasView.drawing = PKDrawing()
                        }) {
                            Text("Clear")
                                .foregroundColor(.red)
                        }
                        
                        Button(action: {
                            viewModel.convertPencilKitViewToImage()
                            viewModel.isShowingView = false
                        }) {
                            Text("Done")
                        }
                    }
                    .padding(20)
                    
                    Spacer()
                }
            }
            .onAppear {
                viewModel.canvasView.drawing = PKDrawing()
            }
        }
    }
}

struct DrawingView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    @Binding var selectedColor: Color
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 3.0)
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = PKInkingTool(.pen, color: UIColor(selectedColor), width: 3.0)
    }
}

class ViewModel: ObservableObject {
    @Published var drawing: UIImage?
    @Published var canvasView = PKCanvasView()
    @Published var isShowingView = false
    
    func convertPencilKitViewToImage() {
        if let image = canvasView.asImage() {
            drawing = image
        }
    }
}

extension PKCanvasView {
    func asImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let image = renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        return image
    }
}

struct contentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
