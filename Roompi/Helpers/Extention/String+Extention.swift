//
//  String+Extention.swift
//  Roompi
//
//  Created by irwan on 10/02/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct TextOptions: OptionSet {
    let rawValue: Int

    static let lowercase = TextOptions(rawValue: 1 << 0)
    static let uppercase = TextOptions(rawValue: 1 << 1)
    static let number = TextOptions(rawValue: 1 << 2)
    /// Supports only solo dash
    static let dash = TextOptions(rawValue: 1 << 3)
    static let underline = TextOptions(rawValue: 1 << 4)
    static let dot = TextOptions(rawValue: 1 << 5)
    static let comma = TextOptions(rawValue: 1 << 6)
    static let slash = TextOptions(rawValue: 1 << 7)
    static let blank = TextOptions(rawValue: 1 << 8)

    static let plus = TextOptions(rawValue: 1 << 9)
    static let at = TextOptions(rawValue: 1 << 10)
    static let newLine = TextOptions(rawValue: 1 << 11)
    static let alphabet: TextOptions = [.lowercase, .uppercase]
    static let addressTextField: TextOptions = [.lowercase, .uppercase, .number, .dash, .dot, .comma, .slash, .blank]
    static let emailTextField: TextOptions = [.lowercase, .uppercase, .number, .dot, .slash, .dash, .plus, .underline, .at]

    static let realNamePolicy: TextOptions = [.alphabet, .blank]
    static let note: TextOptions = [.alphabet, .number, .dot, .comma, .slash, .dash, .blank]
    var regex: String? {
        guard isEmpty == false else {
            return nil
        }

        var regex: String = "[^"

        if contains(.lowercase) {
            regex += "a-z"
        }
        if contains(.uppercase) {
            regex += "A-Z"
        }
        if contains(.number) {
            regex += "0-9"
        }
        if contains(.dash) {
            regex += "-"
        }
        if contains(.underline) {
            regex += "_"
        }
        if contains(.dot) {
            regex += "."
        }
        if contains(.comma) {
            regex += ","
        }
        if contains(.slash) {
            regex += "/"
        }

        if contains(.blank) {
            regex += "\\s"
        }
        if contains(.plus) {
            regex += "+"
        }
        if contains(.at) {
            regex += "@"
        }
        if contains(.newLine) {
            regex += "\n"
        }
        regex += "]"

        return regex
    }
}

extension String {
  var isNotEmpty: Bool {
      !self.isEmpty
  }
}

extension String: HasSetup { }

extension String {
    enum Constant {
        static let backspace: Int = -92
    }

    var removeSlash: String {
        replacingOccurrences(of: "/", with: "", options: .literal, range: nil)
    }
    var removeComma: String {
        replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
    }
    var removeDot: String {
        replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
    }
    var digits: String {
        components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }

  func stringByReplacingMatches(regex: String, options: NSRegularExpression.MatchingOptions = [], withTemplate template: String) -> String {
      do {
          let regexp = try NSRegularExpression(pattern: regex, options: [])

          return regexp.stringByReplacingMatches(in: self, options: options, range: NSRange(location: 0, length: count), withTemplate: template)
      } catch {
          print(error.localizedDescription)

          return self
      }
  }
}
