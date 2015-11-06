//
//  VCMapView.swift
//  HonoluluArt
//
//  Created by Lixiang Mu on 11/5/15.
//  Copyright © 2015 Lixiang Mu. All rights reserved.
//

import Foundation
import MapKit

extension ViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Artwork {
            let identifier = "Pin"
            var view: MKPinAnnotationView
            if let dequeueView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView{
                dequeueView.annotation = annotation
                view = dequeueView
            }else{
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.canShowCallout = true
                view.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure) as UIView
                view.pinTintColor = annotation.pinColor()
            }
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }
}