//
//  NetworkManager.swift
//  collectionViewInsideTableView
//Copyright © 2019 minamagdy. All rights reserved.
//

import Foundation
import Moya

enum Result<T> {
    case success(T)
    case failure(Error)
}
class NetworkManager {
    
      static let shared = NetworkManager()
       
      private let provider = MoyaProvider<APIService>()
      init() {}
    
    
    func requestData<T: Decodable>(endPoint: APIService, decodingType: T.Type,
                                   completionHandler: @escaping (Result<T>) -> Void) {
        provider.request(endPoint) { result in
            switch result {
            case .success(let response):
                do {
                    let model: T =  try JSONDecoder().decode(decodingType.self, from: response.data)
                    completionHandler(Result.success(model))
                } catch let err {
                    completionHandler(Result.failure(err))
                }
            case .failure(let err):
                completionHandler(Result.failure(err))
            }
        }
    }
}
//
