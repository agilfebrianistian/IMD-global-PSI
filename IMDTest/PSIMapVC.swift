//
//  ViewController.swift
//  IMDTest
//
//  Created by Agil Febrianistian on 9/16/17.
//  Copyright © 2017 Agil Febrianistian. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class PSIMapVC : UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var provider: PSIDataProviderProtocol = PSIDataProvider()
    var psiData : PSIData = PSIData()
    var annotations = [MKAnnotation]()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = Date()
        reloadMap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func reloadButtonTapped(_ sender: Any) {
        reloadMap()
    }
    
    func reloadMap(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        provider.getPSIData(dateFormatter.string(from: datePicker.date), {
            self.psiData = $0
            self.updateMap(regionData: self.psiData.regionMetadata)
        })
    }
    
    func updateMap(regionData : [RegionMetadata]){
        self.mapView.removeAnnotations(annotations)
        annotations.removeAll()
        
        for data in regionData {
            if data.labelLocation.latitude > 0 && data.labelLocation.longitude > 0{
                let coordinate = CLLocationCoordinate2DMake(data.labelLocation.latitude, data.labelLocation.longitude)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = data.name
                annotation.subtitle = "tap for details"
                self.annotations.append(annotation)
            }
        }
        self.mapView.addAnnotations(annotations)
        self.mapView.showAnnotations(mapView.annotations, animated: true)
    }
}

extension PSIMapVC : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "PSIDetailsVC") as! PSIDetailsVC
        nextVC.items = self.psiData.items
        nextVC.regionName = view.annotation?.title!
        nextVC.title = view.annotation?.title!?.uppercased()
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
}

