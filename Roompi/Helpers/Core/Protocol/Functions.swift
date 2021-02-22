//
//  Functions.swift
//  Roompi
//
//  Created by irwan on 10/02/21.
//

import Foundation
func run<R>(closure: () -> R) -> R {
    closure()
}

func with<T, R>(_ receiver: T, closure: (T) -> R) -> R {
    closure(receiver)
}
