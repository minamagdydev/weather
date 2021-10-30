//
//  File.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 10/31/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import Foundation

// MARK: - ForecastModel
struct ForecastModel: Codable {
    let cod: String?
    let message: Double?
    let cnt: Int?
    let list: [List]?
    let city: City?
    
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
}


// MARK: - List
struct List: Codable {
    let dt: Int?
    let main: MainClass?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let rain: Rain?
    let sys: Sys?
    let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, rain, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, tempMin, tempMax, pressure: Double?
    let seaLevel, grndLevel: Double?
    let humidity: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}


enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}


enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

enum Description: String, Codable {
    case 中雨 = "中雨"
    case 多云 = "多云"
    case 小雨 = "小雨"
    case 晴 = "晴"
    case 晴少云 = "晴，少云"
}


