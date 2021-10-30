//
//  File.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 11/2/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension BehaviorRelay where Element: RangeReplaceableCollection {
    func acceptAppending(_ element: Element.Element) {
        accept(value + [element])
    }
    public func remove(at index: Element.Index) {
           var newValue = value
           newValue.remove(at: index)
           accept(newValue)
       }
}
