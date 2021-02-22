//
//  HasSetup.swift
//  Roompi
//
//  Created by irwan on 10/02/21.
//

import Foundation

protocol HasSetup { }

extension HasSetup {
    func setup(closure: (Self) -> Void) {
        closure(self)
    }
}

extension NSObject: HasSetup { }
