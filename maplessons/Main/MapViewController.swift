//
//  MapViewController.swift
//  maplessons
//
//  Created by iMac on 01/12/2019.
//  Copyright © 2019 protodimbo. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate {
    
    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        
        view.addSubview(mapView)
        
        
        mapView.translatesAutoresizingMaskIntoConstraints = false //enable auto layout
        //constraints
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        //mapView.showsUserLocation = true
        
        //setupAnnotationsForMap()
        //performLocalSearch()
        
        setupStartEndAnnotations()
        
        requestForDirrections()
    }
    
    fileprivate func requestForDirrections() {
        let request = MKDirections.Request()
        
        let startingPlacemark = MKPlacemark(coordinate: .init(latitude: 37.7666, longitude: -122.427290))
         request.source = .init(placemark: startingPlacemark)
        
        let endingPlacemark = MKPlacemark(coordinate: .init(latitude: 37.331352, longitude: -122.030331))
        request.destination = .init(placemark: endingPlacemark)
        
        //transport type
        request.transportType = .any
        
        
        let dirrections = MKDirections(request: request)
        dirrections.calculate { (resp, err) in
            if let err = err {
                print("Failed to find routing dirrections :", err)
                return
            } else {
                //success
                print("Found dirrections")
                guard let route = resp?.routes.first else { return }
                //transport есть
                self.mapView.addOverlay(route.polyline)
                }
            }
        }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = .red
        polylineRenderer.lineWidth = 5
        return polylineRenderer
    }
    
    fileprivate func setupStartEndAnnotations() {
        let startAnnotation = MKPointAnnotation()
        startAnnotation.coordinate = .init(latitude: 37.7666, longitude: -122.427290)
        startAnnotation.title = "Start"
        mapView.addAnnotation(startAnnotation)
        
        
        let endAnnotation = MKPointAnnotation()
        endAnnotation.coordinate = .init(latitude: 37.331352, longitude: -122.030331)
        endAnnotation.title = "END"
        mapView.addAnnotation(endAnnotation)
        
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    
    fileprivate func performLocalSearch() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "New York"
        //мб нужен регион
        
        let localSearch = MKLocalSearch(request: request)
        localSearch.start { (resp, err) in
            if let err = err {
                print("Failed local search:", err)
                return
            } else {
                //Success
                resp?.mapItems.forEach({ (mapItem) in
                    print(mapItem.name ?? "")
                    
                    let annotaion = MKPointAnnotation()
                    annotaion.coordinate = mapItem.placemark.coordinate
                    annotaion.title = mapItem.name
                    self.mapView.addAnnotation(annotaion)
                 //   mapItem.placemark.coordinate
                })
                self.mapView.showAnnotations(self.mapView.annotations, animated: true)
            }
        }
    }
    
    fileprivate func setupAnnotationsForMap() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.7666, longitude: -122.427290)
        annotation.title = "SAN Francisco"
        annotation.subtitle = "California"
        mapView.addAnnotation(annotation)
    
        
        let newYorkAnnotation = MKPointAnnotation()
        newYorkAnnotation.coordinate = .init(latitude: 40.772399, longitude: -73.972677)
        newYorkAnnotation.title = "New York"
        newYorkAnnotation.subtitle = "New York"
        mapView.addAnnotation(newYorkAnnotation)
        
        //show two point on view
        
        mapView.showAnnotations(self.mapView.annotations, animated: true) //слишком близко приближает, возможно нужно избавиться от тайтлов
        
        
    }
    
    
}

