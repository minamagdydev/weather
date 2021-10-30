//
//  File.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 10/29/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import Foundation
import CoreLocation

public class LocationManager: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var coordinate: CLLocationCoordinate2D?
    var locationCallback: ((CLLocation?) -> Void)!
    var locationServicesEnabled = false
    var didFailWithError: Error?

    public func request(callback: @escaping (CLLocation?) -> Void) {
        locationCallback = callback
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.requestWhenInUseAuthorization()
        locationServicesEnabled = CLLocationManager.locationServicesEnabled()
        if locationServicesEnabled { manager.startUpdatingLocation() } else { locationCallback(nil) }
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationCallback(locations.last!)
        locationCallback = nil
        manager.stopUpdatingLocation()
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didFailWithError = error
        locationCallback(nil)
        manager.stopUpdatingLocation()
    }

    deinit {
        manager.stopUpdatingLocation()
    }
    
}
