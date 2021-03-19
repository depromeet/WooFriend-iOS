//
//  DirectLocalViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs
import RxSwift
import UIKit
import NMapsMap
import CoreLocation
import UserNotifications

protocol DirectLocalPresentableListener: class {
    func nextAcion()
    func backAction()
}

final class DirectLocalViewController: BaseViewController, DirectLocalPresentable, DirectLocalViewControllable, CLLocationManagerDelegate, NMFMapViewCameraDelegate {
    
    weak var listener: DirectLocalPresentableListener?
    var locationManager: CLLocationManager!
    //    let locationOverlay:
    var center: UNUserNotificationCenter!
    var address: String = ""
    private var isFirst = true
    
    @IBOutlet weak var mapView: NMFMapView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindUI()
    }
    
    private func setUI() {
        mapView.allowsRotating = false
        mapView.allowsTilting = false
        mapView.allowsZooming = false
        mapView.addCameraDelegate(delegate: self)
        locationManager = CLLocationManager()
        center = UNUserNotificationCenter.current()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        } else {
            print(231231)
        }
    }
    
    private func bindUI() {
        
        nextButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] b in
                guard let self = self else { return }
                self.listener?.nextAcion()
                
            })
            .disposed(by: disposeBag)
        
        backButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] b in
                guard let self = self else { return }
                
                self.listener?.backAction()
            })
            .disposed(by: disposeBag)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else { return }
        
        if isFirst {
            isFirst.toggle()
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(from: location.coordinate))
            mapView.moveCamera(cameraUpdate)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        
        let location = mapView.cameraPosition.target
        
        let findLocation = CLLocation(latitude: location.lat, longitude: location.lng )
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            
            if let address: [CLPlacemark] = placemarks {
                
                let area = address.first?.administrativeArea ?? ""
                let si = address.first?.locality ?? ""
                let name = Scanner(string: address.first?.name ?? "").scanUpToString(" ") ?? ""
                
                self.address = "\(area) \(si) \(name)"
            }
        })
    }
}


