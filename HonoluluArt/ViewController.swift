//
//  ViewController.swift
//  HonoluluArt
//
//  Created by Lixiang Mu on 11/4/15.
//  Copyright © 2015 Lixiang Mu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var artworks = [Artwork]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)
        
//        let artwork = Artwork(title: "大卫国王雕像",
//            locationName: "夏威夷门公园",
//            discipline: "Sculpture",
//            coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
//        mapView.addAnnotation(artwork)
        loadInitialDtata()
        mapView.addAnnotations(artworks)
    }

    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func loadInitialDtata(){
        let filename = NSBundle.mainBundle().pathForResource("PublicArt", ofType: "json")
        
        var data: NSData?
        do{
            data = try NSData(contentsOfFile: filename!, options: NSDataReadingOptions(rawValue: 0))
        }catch _ {
            data = nil
        }
        
        var jsonObject: AnyObject?
        
        if let data = data {
            do {
                jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
            }catch _ {
                jsonObject = nil
            }
        }
        
        if let jsonObject = jsonObject as? [String: AnyObject], let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array{
            for artworkJSON in jsonData {
                if let artworkJSON = artworkJSON.array, artwork = Artwork.fromJSON(artworkJSON){
                    artworks.append(artwork)
                }
            }
        }
        
    }
}

