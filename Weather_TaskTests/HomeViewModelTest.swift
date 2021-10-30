//
//  HomeViewModelTest.swift
//  Weather_TaskTests
//
//  Created by NowPayMacmini-1 on 11/4/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Weather_Task

class HomeViewModelTest: XCTestCase {
    
    var sut: HomeViewModel!
    
    override func setUp() {
        sut = HomeViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_Init_WeatherObservable_EqualZero() {
        let count = sut.weatherDataBehavior.value.count
        XCTAssertEqual(count, 0, "should return 0")
    }
    
    func test_Add_WeatherObservable_NotEqualZero() {
        let testCountryWeather = CountryWeatherModel(coord: nil, weather: [], base: "", main: nil, visibility: 0, wind: nil, clouds: nil, dt: 0, sys: nil, timezone: 0, id: 0, name: "", cod: 0)
        sut.addCountryWeather(model: [testCountryWeather])
        let count = sut.weatherDataBehavior.value.count
         XCTAssertNotEqual(count, 0)
    }
    
    func test_DefaultLocation_NotEqualZero() {
        let exp = expectation(description: "Loading location")
        
        sut.fetchCurrentLocationData(defaultCountry: true) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 6)
        let count = sut.weatherDataBehavior.value.count
        XCTAssertNotEqual(count, 0)
    }
    
    func test_DefaultLocation_EqualLondon() {
        let exp = expectation(description: "Loading location")
        
        sut.fetchCurrentLocationData(defaultCountry: true) {
            exp.fulfill()
        }
        waitForExpectations(timeout: 6)
        let name = sut.weatherDataBehavior.value[0].name
        XCTAssertEqual(name ?? "", "London")
    }
    
    func test_OtherLocation_NotEqualLondon() {
        
        let latitude = 26.8206
        let longitude = 30.8025
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        sut.coordinate = coordinate
         let exp = expectation(description: "Loading location")
         
         sut.fetchCurrentLocationData(defaultCountry: false) {
             exp.fulfill()
         }
         waitForExpectations(timeout: 6)
         let name = sut.weatherDataBehavior.value[0].name
         XCTAssertNotEqual(name ?? "", "London")
     }
    
}
