//
//  ListOfLocationViewModelText.swift
//  Weather_TaskTests
//
//  Created by NowPayMacmini-1 on 11/4/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import Foundation

import XCTest
import CoreLocation
import RxSwift
import RxCocoa
@testable import Weather_Task

class ListOfLocationViewModelText: XCTestCase {
    
    var sut: ListOfLocationsViewModel!
    var testCountryWeather: CountryWeatherModel!
    var testCountryWeather1: CountryWeatherModel!
    var testCountryWeather2: CountryWeatherModel!
    
    override func setUp() {
        let coord = Coord(lon: 26.8206, lat: 30.8025)
        testCountryWeather = CountryWeatherModel(coord: coord, weather: [], base: "", main: nil, visibility: 0, wind: nil, clouds: nil, dt: 0, sys: nil, timezone: 0, id: 0, name: "London", cod: 0)
        testCountryWeather1 = CountryWeatherModel(coord: coord, weather: [], base: "", main: nil, visibility: 0, wind: nil, clouds: nil, dt: 0, sys: nil, timezone: 0, id: 0, name: "London1", cod: 0)
        testCountryWeather2 = CountryWeatherModel(coord: coord, weather: [], base: "", main: nil, visibility: 0, wind: nil, clouds: nil, dt: 0, sys: nil, timezone: 0, id: 0, name: "London2", cod: 0)
        let weatherDataBehavior: BehaviorRelay<[CountryWeatherModel]> = .init(value: [testCountryWeather!])
        sut = ListOfLocationsViewModel(weatherDataBehavior: weatherDataBehavior)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_Add_WeatherObservable_NotEqualZero() {
        let count = sut.weatherDataBehavior.value.count
         XCTAssertNotEqual(count, 0)
    }

    func test_DefaultLocation_EqualLondon() {
        let name = sut.weatherDataBehavior.value[0].name
        XCTAssertEqual(name ?? "", "London")
    }
    
    func test_dontAccept_redundancy() {
        let count = sut.weatherDataBehavior.value.count
        XCTAssertEqual(count, 1)
        sut.addCountryWeather(model: testCountryWeather!)
        XCTAssertEqual(count, 1)
    }
    
    func test_maxCount_Equal5() {
        sut.weatherDataBehavior.accept([testCountryWeather, testCountryWeather, testCountryWeather, testCountryWeather])
        sut.addCountryWeather(model: testCountryWeather1)
        var count = sut.weatherDataBehavior.value.count
        XCTAssertEqual(count, 5)
        sut.addCountryWeather(model: testCountryWeather2)
        count = sut.weatherDataBehavior.value.count
        XCTAssertEqual(count, 5)
    }
    
    func test_removeItem() {
        var count = sut.weatherDataBehavior.value.count
        XCTAssertEqual(count, 1)
        sut.removeItem(atRow: 0)
        count = sut.weatherDataBehavior.value.count
        XCTAssertEqual(count, 0)
    }

}
