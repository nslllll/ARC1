//
//  Location.swift
//  ARC1
//
//  Created by Ng Sui Lam on 16/2/2024.
//

import Foundation
import SwiftUI
import CoreLocation
import CoreLocationUI
import MapKit

struct Shop: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct location : View {
    
    let annotations = [
        Shop(name: "印衫易 Print32hk", coordinate: CLLocationCoordinate2D(latitude: 22.308844440789912, longitude: 114.18885346859264)),
        Shop(name: "uLabel", coordinate: CLLocationCoordinate2D(latitude: 22.30902044697339, longitude: 114.22347335694833)),
        Shop(name: "TT Printing 至尊印衫", coordinate: CLLocationCoordinate2D(latitude: 22.358322791464875, longitude: 114.13244786194592)),
        Shop(name: "炬意製品", coordinate: CLLocationCoordinate2D(latitude: 22.311622445358783, longitude: 114.22702247229074))
    ]

    @StateObject var locationModel = LocationModel()
    @State var coordinateRegion : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    
    var body: some View {
        VStack {
            if locationModel.authorizationStatus == .authorizedWhenInUse ||
                locationModel.authorizationStatus == .authorizedAlways {
                
               
                Map(coordinateRegion: $locationModel.coordinateRegion,
                    showsUserLocation: true,
                    annotationItems: annotations){
                    MapMarker(coordinate: $0.coordinate)
                }
            } else {
                Button("Request Permisison", action: {
                    locationModel.requestPermission()
                })
            }
            
        }
        .padding()
    }
}

struct location_Previews : PreviewProvider {
    static var previews: some View {
        location()
    }
}

