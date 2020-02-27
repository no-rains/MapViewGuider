//
//  MapView.swift
//  MapViewGuider
//
//  Created by norains on 2020/2/26.
//  Copyright © 2020 norains. All rights reserved.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    @ObservedObject var mapViewState: MapViewState
    var mapViewDelegate: MapViewDelegate

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = mapViewDelegate
        mapView.addAnnotation(mapViewState.pinAnnotation!)
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        // Set the map display region
        if let center = mapViewState.center {
            var region: MKCoordinateRegion
            if let span = mapViewState.span {
                region = MKCoordinateRegion(center: center,
                                            span: span)
            } else {
                region = MKCoordinateRegion(center: center,
                                            latitudinalMeters: CLLocationDistance(400),
                                            longitudinalMeters: CLLocationDistance(400))
            }
            view.setRegion(region, animated: true)

            mapViewState.center = nil
        }
    }
}
