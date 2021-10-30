//
//  File.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 10/29/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa

class BaseViewModel: ViewModel {
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    
    
}
