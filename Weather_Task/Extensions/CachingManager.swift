//
//  userDefault.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 11/3/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import Foundation

final class CachingManager {
    static let shared = CachingManager()
    let cach = UserDefaults.standard
    private init() {
    }
    
    func cache<T: Encodable>(_ obj: T, with key: CachKeys) -> Bool {
        guard let data = try? JSONEncoder().encode(obj) else {return false}
        cach.setValue(data, forKey: key.rawValue)
        cach.synchronize()
        return true
    }
    func cache<T: Encodable>(_ obj: T, with key: String) -> Bool {
        guard let data = try? JSONEncoder().encode(obj) else {return false}
        cach.setValue(data, forKey: key)
        cach.synchronize()
        return true
    }
    func clear(with key: CachKeys) {
        cach.setValue(nil, forKey: key.rawValue)
        cach.synchronize()
    }
    
    func set(_ obj: Any, with key: CachKeys) {
        cach.setValue(obj, forKey: key.rawValue)
        cach.synchronize()
    }
    
    func get<T>(value of: CachKeys) -> T? {
        return cach.value(forKey: of.rawValue) as? T
    }
    func getCached<T: Decodable>(value of: CachKeys) -> T? {
        if let data = cach.value(forKey: of.rawValue) as? Data {
            let obj = try? JSONDecoder().decode(T.self, from: data)
            return obj
        }
        return nil
    }
    func getCached<T: Decodable>(value of: String) -> T? {
        if let data = cach.value(forKey: of) as? Data {
            let obj = try? JSONDecoder().decode(T.self, from: data)
            return obj
        }
        return nil
    }
    func resetApp() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    }
}

enum CachKeys: String {
    case countryWeather
    case home
    case list
}
