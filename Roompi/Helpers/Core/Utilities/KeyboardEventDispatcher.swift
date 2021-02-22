//
//  KeyboardEventDispatcher.swift
//  Roompi
//
//  Created by irwan on 18/02/21.
//

import Foundation
import UIKit

final class KeyboardEventDispatcher {
    enum ConcealableKeyboardGesture {
        case tap
        case pan
        case pinch
    }

    func recognizer(type: ConcealableKeyboardGesture?, target: Any?, action: Selector?) -> UIGestureRecognizer? {
        guard let type = type else { return nil }

        var recognizer: UIGestureRecognizer?

        switch type {
        case .tap:
            recognizer = UITapGestureRecognizer(target: target, action: action)
        case .pan:
            recognizer = UIPanGestureRecognizer(target: target, action: action)
        case .pinch:
            recognizer = UIPinchGestureRecognizer(target: target, action: action)
        }
        recognizer?.cancelsTouchesInView = false
        return recognizer
    }
}
