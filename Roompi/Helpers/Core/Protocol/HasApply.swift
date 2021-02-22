//
//  HasApply.swift
//  Roompi
//
//  Created by irwan on 10/02/21.
//

import Foundation

protocol HasApply { }

extension HasApply {
    @discardableResult
    func apply(closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: HasApply { }
