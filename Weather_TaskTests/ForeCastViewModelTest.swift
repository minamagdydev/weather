//
//  ForeCastViewModelTest.swift
//  Weather_TaskTests
//
//  Created by NowPayMacmini-1 on 11/4/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Weather_Task

class ForeCastViewModelTest: XCTestCase {
    
    var sut: ForecastViewModel!
    let disposeBag = DisposeBag()
    override func setUp() {
        sut = ForecastViewModel(countryID: "20")
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_initailValueEqualNotNil() {
        XCTAssertNotNil(sut.forecastDataBehavior)
    }
    
    func test_afterCallingNotEqualNil() {
        var forecastModel: ForecastModel!
        let exp = expectation(description: "Loading location")
        let expObser = expectation(description: "Loading observation")
        let latitude = 26.8206
        let longitude = 30.8025
        sut.fetchForecastData(long: latitude, lat: longitude) {
            exp.fulfill()
        }
        sut.forecastDataBehavior.subscribe(onNext: { model in
            forecastModel = model
            expObser.fulfill()
        }).disposed(by: disposeBag)
        waitForExpectations(timeout: 10)
        XCTAssertNotNil(forecastModel)
    }
    
}
