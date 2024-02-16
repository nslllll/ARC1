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
        Shop(name: "London", coordinate: CLLocationCoordinate2D(latitude: 22.31001626873344, longitude: 114.22756546042852)),
        Shop(name: "Paris", coordinate: CLLocationCoordinate2D(latitude: 22.309400873274026, longitude: 114.2252051166032)),
        Shop(name: "Rome", coordinate: CLLocationCoordinate2D(latitude: 22.35858079078863, longitude: 114.13168611675623)),
        Shop(name: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 22.308943719105212, longitude: 114.1888534707294))
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

