//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Devontae Reid on 1/30/18.
//  Copyright © 2018 Devontae Reid. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    let mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    let zoomInOnPostionButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Zoom", for: .normal)
        btn.backgroundColor = UIColor(red: 87/256, green: 138/256, blue: 219/256, alpha: 1.0)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        return btn
    }()
    
    let detailsButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Pin Details", for: .normal)
        btn.isEnabled = false
        btn.backgroundColor = UIColor(red: 87/256, green: 138/256, blue: 219/256, alpha: 1.0)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        return btn
    }()
    var selectedAnnotation: MKPointAnnotation?
    var locations = [CLLocationCoordinate2D(latitude: 33.9233641, longitude: -118.24517),CLLocationCoordinate2D(latitude: 33.882396, longitude: -117.8830718),CLLocationCoordinate2D(latitude: 36.1032105, longitude: -115.1764464)]
    
    override func loadView() {
        super.loadView()
        view = mapView
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        let segController = UISegmentedControl(items: ["Standard","Hybrid","Satelite"])
        segController.tintColor = UIColor(red: 87/256, green: 138/256, blue: 219/256, alpha: 1.0)
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
        
        view.addSubview(zoomInOnPostionButton)
        zoomInOnPostionButton.addTarget(self, action: #selector(zoomInOnPostion(_:)), for: .touchUpInside)
        
        let buttonBottomConstraint = zoomInOnPostionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        let buttonLeadingConstraint = zoomInOnPostionButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        let buttonWidthConstraint = zoomInOnPostionButton.widthAnchor.constraint(equalToConstant: 80)
        let buttonHeightConstraint = zoomInOnPostionButton.heightAnchor.constraint(equalToConstant: 40)
        
        view.addSubview(detailsButton)
        detailsButton.addTarget(self, action: #selector(displayLocationOfAnnotation), for: .touchUpInside)
        
        let detailsButtonBottomConstraint = detailsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        let detailsButtonLeadingConstraint = detailsButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let detailsButtonWidthConstraint = detailsButton.widthAnchor.constraint(equalToConstant: 160)
        let detailsButtonHeightConstraint = detailsButton.heightAnchor.constraint(equalToConstant: 40)
        
        buttonBottomConstraint.isActive = true
        buttonLeadingConstraint.isActive = true
        buttonWidthConstraint.isActive = true
        buttonHeightConstraint.isActive = true
        
        detailsButtonBottomConstraint.isActive = true
        detailsButtonLeadingConstraint.isActive = true
        detailsButtonWidthConstraint.isActive = true
        detailsButtonHeightConstraint.isActive = true
        
        locationsOfInterest()
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
    
    @objc func zoomInOnPostion(_ : UIButton) {
        let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
    func locationsOfInterest() {
        let birthLocation = locations[0]
        let currentLocation = locations[1]
        let interestLocation = locations[2]
        
        let birthAnnotation = MKPointAnnotation()
        birthAnnotation.coordinate = birthLocation
        birthAnnotation.title = "Martin Luther King Hospital"
        birthAnnotation.subtitle = "Birthplace of Devontae Reid"
        
        let currentAnnotation = MKPointAnnotation()
        currentAnnotation.coordinate = currentLocation
        currentAnnotation.title = "California State University, Fullerton"
        currentAnnotation.subtitle = "My current location"
        
        let eiffelAnnotation = MKPointAnnotation()
        eiffelAnnotation.coordinate = interestLocation
        eiffelAnnotation.title = "ARIA Resort & Casino Las Vegas"
        eiffelAnnotation.subtitle = "Interesting Place I visited!"
        
        mapView.addAnnotation(birthAnnotation)
        mapView.addAnnotation(currentAnnotation)
        mapView.addAnnotation(eiffelAnnotation)
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.selectedAnnotation = view.annotation as? MKPointAnnotation
        if self.selectedAnnotation != nil {
            self.detailsButton.isEnabled = true
        } else {
            self.detailsButton.isEnabled = false
        }
    }
    
    @objc func displayLocationOfAnnotation() {
        let coordinate = selectedAnnotation!.coordinate
        createAlert(title: (selectedAnnotation?.title)!, message: "Latitude: \(String(describing: coordinate.latitude)) , Longitude: \(String(describing: coordinate.longitude))")
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
