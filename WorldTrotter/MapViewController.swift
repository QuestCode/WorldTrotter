//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Devontae Reid on 1/30/18.
//  Copyright © 2018 Devontae Reid. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    override func loadView() {
        super.loadView()
        view = mapView
        
        let segController = UISegmentedControl(items: ["Standard","Hybrid","Satelite"])
        segController.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segController.selectedSegmentIndex = 0
        segController.translatesAutoresizingMaskIntoConstraints = false
        segController.addTarget(self, action: #selector(setMapType(_:)), for: UIControlEvents.valueChanged)
        view.addSubview(segController)
        
        let topConstraint = segController.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segController.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segController.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func setMapType(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }

}
