//
//  File.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 10/29/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import Foundation

struct WeatherLocation: Codable, Equatable {
    var city: String!
    var country: String!
    var countryCode: String!
    var isCurrentLocation: Bool!
}
