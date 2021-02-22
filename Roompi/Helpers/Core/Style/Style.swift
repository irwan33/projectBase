//
//  Style.swift
//  Roompi
//
//  Created by irwan on 10/02/21.
//

import UIKit

protocol StyleProtocol {
    func applyStyle(font: Style.Font, color: Style.Color?, alpha: CGFloat?)
}

extension StyleProtocol {
    func applyStyle(info: Style.Info) {
        applyStyle(font: info.font, color: info.color, alpha: info.alpha)
    }

    func applyStyle(font: Style.Font, color: Style.Color?) {
        applyStyle(font: font, color: color, alpha: nil)
    }
}

extension UILabel: StyleProtocol {
    func applyStyle(font: Style.Font, color: Style.Color? = nil, alpha: CGFloat? = nil) {
        self.font = font.value
        if let color = color {
            self.textColor = color.value.withAlphaComponent(alpha ?? 1.0)
        }
    }
}

extension UIButton: StyleProtocol {
    func applyStyle(font: Style.Font, color: Style.Color? = nil, alpha: CGFloat? = nil) {
        self.titleLabel?.font = font.value
        if let color = color {
            self.setTitleColor(color.value.withAlphaComponent(alpha ?? 1.0), for: .normal)
        }
    }
}

extension UITextView: StyleProtocol {
    func applyStyle(font: Style.Font, color: Style.Color? = nil, alpha: CGFloat? = nil) {
        self.font = font.value
        if let color = color {
            self.textColor = color.value.withAlphaComponent(alpha ?? 1.0)
        }
    }
}

extension UITextField: StyleProtocol {
    func applyStyle(font: Style.Font, color: Style.Color? = nil, alpha: CGFloat? = nil) {
        self.font = font.value
        if let color = color {
            self.textColor = color.value.withAlphaComponent(alpha ?? 1.0)
        }
    }
}

// MARK: - Utility
extension UIColor {
    static func style(_ styleColor: Style.Color) -> UIColor { styleColor.value }
}

extension UIFont {
    static func style(_ styleFont: Style.Font) -> UIFont { styleFont.value }
}

enum Style {
    typealias Info = (font: Style.Font, color: Style.Color, alpha: CGFloat?)
}

// MARK: - Theme
extension Style {
    enum Theme {
        case light
        case dark
    }
}

// MARK: - Font
extension Style.Font {
    enum `Type` {
        case system
        case dinmed

        var name: String {
            switch self {
            case .dinmed:
                return "DIN Pro"
            default:
                return ""
            }
        }
    }
}

extension Style {
    enum Font {
        // MARK: Head
        /// Size: 34, Default Weight: bold
        case head1(_ weight: UIFont.Weight = .bold)
        /// Size: 30, Default Weight: bold
        case head2(_ weight: UIFont.Weight = .bold)
        /// Size: 24, Default Weight: regular
        case head3(_ weight: UIFont.Weight = .regular)
        /// Size: 22, Default Weight: regular
        case head4(_ weight: UIFont.Weight = .regular)

        // MARK: SubTitle
        /// Size: 20, Default Weight: regular
        case subtitle1(_ weight: UIFont.Weight = .regular)
        /// Size: 19, Default Weight: regular
        case subtitle2(_ weight: UIFont.Weight = .regular)
        /// Size: 18, Default Weight: regular
        case subtitle3(_ weight: UIFont.Weight = .regular)
        /// Size: 17, Default Weight: regular
        case subtitle4(_ weight: UIFont.Weight = .regular)

        // MARK: Body
        /// Size: 16, Default Weight: regular
        case body1(_ weight: UIFont.Weight = .regular)
        /// Size: 15, Default Weight: regular
        case body2(_ weight: UIFont.Weight = .regular)
        /// Size: 14, Default Weight: regular
        case body3(_ weight: UIFont.Weight = .regular)
        /// Size: 13, Default Weight: regular
        case body4(_ weight: UIFont.Weight = .regular)
        /// Size: 12, Default Weight: regular
        case body5(_ weight: UIFont.Weight = .regular)

        /// Size: 11, Default Weight: bold
        case micro1(_ weight: UIFont.Weight = .bold)
        /// Size: 10, Default Weight: bold
        case micro2(_ weight: UIFont.Weight = .bold)

        /// Size: 17, Default Weight: regular
        case buttonTitle1(_ weight: UIFont.Weight = .regular)

        case dinmed(_ size: CGFloat)

        /// Custom size
        case custom(_ size: CGFloat, weight: UIFont.Weight = .regular)

        enum Currency {
            /// Size - default: 53, digit: 55
            case no1
            /// Size - default: 46, digit: 48
            case no2
            /// Size - default: 42, digit: 44
            case no3
            /// Size - default: 39, digit: 40
            case no4
            /// Size - default: 31, digit: 32
            case no5
            /// Size - default: 36, digit: 38
            case totalBalance
            /// Size - default: 30, digit: 32
            case totalBalanceLoan
            case dinmed(_ size: CGFloat)

            var size: (`default`: CGFloat, digit: CGFloat) {
                switch self {
                case .no1:
                    return (53, 55)
                case .no2:
                    return (46, 48)
                case .no3:
                    return (42, 44)
                case .no4:
                    return (39, 40)
                case .no5:
                    return (31, 32)
                case .totalBalance:
                    return (36, 38)
                case .totalBalanceLoan:
                    return (30, 32)
                case let .dinmed(size):
                    return (size, size)
                }
            }

            var `default`: Style.Font { .dinmed(size.default) }
            var digit: Style.Font { .dinmed(size.digit) }
        }
    }
}

extension Style.Font {
    var value: UIFont {
        switch self {
        // MARK: Head
        case let .head1(weight): return .systemFont(ofSize: 34, weight: weight)
        case let .head2(weight): return .systemFont(ofSize: 30, weight: weight)
        case let .head3(weight): return .systemFont(ofSize: 24, weight: weight)
        case let .head4(weight): return .systemFont(ofSize: 22, weight: weight)

        // MARK: SubTitle
        case let .subtitle1(weight): return .systemFont(ofSize: 20, weight: weight)
        case let .subtitle2(weight): return .systemFont(ofSize: 19, weight: weight)
        case let .subtitle3(weight): return .systemFont(ofSize: 18, weight: weight)
        case let .subtitle4(weight): return .systemFont(ofSize: 17, weight: weight)

        // MARK: Body
        case let .body1(weight): return .systemFont(ofSize: 16, weight: weight)
        case let .body2(weight): return .systemFont(ofSize: 15, weight: weight)
        case let .body3(weight): return .systemFont(ofSize: 14, weight: weight)
        case let .body4(weight): return .systemFont(ofSize: 13, weight: weight)
        case let .body5(weight): return .systemFont(ofSize: 12, weight: weight)

        // MARK: Micro
        case let .micro1(weight): return .systemFont(ofSize: 11, weight: weight)
        case let .micro2(weight): return .systemFont(ofSize: 10, weight: weight)

        // MARK: Button Title
        case let .buttonTitle1(weight): return .systemFont(ofSize: 17, weight: weight)

        // MARK: Dinmed
        case let .dinmed(size):
            guard let font = UIFont(name: Type.dinmed.name, size: size) else {
                return .systemFont(ofSize: size)
            }

            return font
        case let .custom(size, weight):
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
    }
}

// MARK: - Color
// swiftlint:disable identifier_name
extension Style {
    enum Color {
        // MARK: Black
        case black_000000
        case black_222222
        case black_2B2B2B
        case black_333333
        case black_434343
        case black_2F374F

        // MARK: White
        case white_FFFFFF
        case white_F2F3F7
        case white_BCE3FD

        // MARK: Red
        case red_FF3A44
        case red_FF3704
        case red_FF3E3E
        case red_FF7D7F
        case red_FF7E8A
        case red_FF0008
        case red_DB1425

        // MARK: Green
        case green_00CC6C
        case green_24C875
        case green_B2EBCE
        case green_1EAA63
        case green_00B8C5
        case green_02BF5F
        case green_4AC687

        // MARK: Blue
        case blue_007AFF
        case blue_426BF2
        case blue_4E93F3
        case blue_20A4F9
        case blue_8FB4DF
        case blue_5078F2
        case blue_A2D6F5

        // MARK: Purple
        case purple_9060EF

        // MARK: Pink
        case pink_FF6DC1
        case pink_FF7066

        // MARK: Orange
        case orange_FF7E4B
        case orange_FE9F3A

        // MARK: Yellow
        case yellow_FDCD12

        // MARK: Brown
        case brown_BC8161
        case brown_745F53
        case brown_9E583E

        // MARK: Gray
        case gray_7B7F81
        case gray_494C4E
        case gray_5D5C63
        case gray_6A7082
        case gray_F2F3F7
        case gray_F8F8F8
        case gray_ECECEC
        case gray_FAFAFD
        case gray_97999E
        case gray_D0D0D5
        case gray_C0C1C4
        case gray_C1C1C1
        case gray_E9E9E9
        case gray_E7E9F1
        case gray_808288
        case gray_F7F8FA
        case gray_B3B5B9
        case gray_E3E5EC
        case gray_ECEDF3
        case gray_D0D0D7
        case gray_84868C
        case gray_74767D
        case gray_85909B
        case gray_F5F7FB
        case gray_717171
        case gray_767676
        case gray_B3B4B9
        case gray_B2B5B9
        case gray_F6F7F9
        case gray_BDC1C7
        case gray_D8D8D8
        case gray_ADBED2
        case gray_EAEAEA

        // MARK: Pale Lilac
        case paleLilac_E3E5EC
        case paleGrey_F2F3F9

        // MARK: Primitive Color
        case black
        case white
        case red
        case green
        case blue
    }
}

extension Style.Color {
    var value: UIColor {
        switch self {
        // MARK: Black
        case .black_000000: return .hexadecimal("000000")
        case .black_222222: return .hexadecimal("222222")
        case .black_2B2B2B: return .hexadecimal("2B2B2B")
        case .black_333333: return .hexadecimal("333333")
        case .black_434343: return .hexadecimal("434343")
        case .black_2F374F: return .hexadecimal("2F374F")

        // MARK: White
        case .white_FFFFFF: return .hexadecimal("FFFFFF")
        case .white_F2F3F7: return .hexadecimal("F2F3F7")
        case .white_BCE3FD: return .hexadecimal("BCE3FD")

        // MARK: Red
        case .red_FF3A44: return .hexadecimal("FF3A44")
        case .red_FF3704: return .hexadecimal("FF3704")
        case .red_FF3E3E: return .hexadecimal("FF3E3E")
        case .red_FF7D7F: return .hexadecimal("FF7D7F")
        case .red_FF7E8A: return .hexadecimal("FF7E8A")
        case .red_FF0008: return .hexadecimal("FF0008")
        case .red_DB1425: return .hexadecimal("DB1425")

        // MARK: Green
        case .green_00CC6C: return .hexadecimal("00CC6C")
        case .green_24C875: return .hexadecimal("24C875")
        case .green_B2EBCE: return .hexadecimal("B2EBCE")
        case .green_1EAA63: return .hexadecimal("1EAA63")
        case .green_00B8C5: return .hexadecimal("00B8C5")
        case .green_02BF5F: return .hexadecimal("02BF5F")
        case .green_4AC687: return .hexadecimal("4AC687")

        // Blue
        case .blue_007AFF: return .hexadecimal("007AFF")
        case .blue_426BF2: return .hexadecimal("426BF2")
        case .blue_4E93F3: return .hexadecimal("4E93F3")
        case .blue_20A4F9: return .hexadecimal("20A4F9")
        case .blue_8FB4DF: return .hexadecimal("8FB4DF")
        case .blue_5078F2: return .hexadecimal("5078F2")
        case .blue_A2D6F5: return .hexadecimal("A2D6F5")


        // MARK: Purple
        case .purple_9060EF: return .hexadecimal("9060EF")

        // MARK: Pink
        case .pink_FF6DC1: return .hexadecimal("FF6DC1")
        case .pink_FF7066: return .hexadecimal("FF7066")

        // MARK: Orange
        case .orange_FF7E4B: return .hexadecimal("FF7E4B")
        case .orange_FE9F3A: return .hexadecimal("FE9F3A")

        // MARK: Yellow
        case .yellow_FDCD12: return .hexadecimal("FDCD12")

        // MARK: Brown
        case .brown_BC8161: return .hexadecimal("BC8161")
        case .brown_745F53: return .hexadecimal("745F53")
        case .brown_9E583E: return .hexadecimal("9E583E")

        // MARK: Gray
        case .gray_7B7F81: return .hexadecimal("7B7F81")
        case .gray_494C4E: return .hexadecimal("494C4E")
        case .gray_5D5C63: return .hexadecimal("5D5C63")
        case .gray_6A7082: return .hexadecimal("6A7082")
        case .gray_F2F3F7: return .hexadecimal("F2F3F7")
        case .gray_F8F8F8: return .hexadecimal("F8F8F8")
        case .gray_ECECEC: return .hexadecimal("ECECEC")
        case .gray_FAFAFD: return .hexadecimal("FAFAFD")
        case .gray_97999E: return .hexadecimal("97999E")
        case .gray_D0D0D5: return .hexadecimal("D0D0D5")
        case .gray_C0C1C4: return .hexadecimal("C0C1C4")
        case .gray_C1C1C1: return .hexadecimal("C1C1C1")
        case .gray_E9E9E9: return .hexadecimal("E9E9E9")
        case .gray_E7E9F1: return .hexadecimal("E7E9F1")
        case .gray_808288: return .hexadecimal("808288")
        case .gray_F7F8FA: return .hexadecimal("F7F8FA")
        case .gray_B3B5B9: return .hexadecimal("B3B5B9")
        case .gray_E3E5EC: return .hexadecimal("E3E5EC")
        case .gray_ECEDF3: return .hexadecimal("ECEDF3")
        case .gray_D0D0D7: return .hexadecimal("D0D0D7")
        case .gray_84868C: return .hexadecimal("84868C")
        case .gray_74767D: return .hexadecimal("74767D")
        case .gray_85909B: return .hexadecimal("85909B")
        case .gray_F5F7FB: return .hexadecimal("F5F7FB")
        case .gray_717171: return .hexadecimal("717171")
        case .gray_767676: return .hexadecimal("767676")
        case .gray_B3B4B9: return .hexadecimal("B3B4B9")
        case .gray_B2B5B9: return .hexadecimal("B2B5B9")
        case .gray_F6F7F9: return .hexadecimal("F6F7F9")
        case .gray_BDC1C7: return .hexadecimal("BDC1C7")
        case .gray_D8D8D8: return .hexadecimal("D8D8D8")
        case .gray_ADBED2: return .hexadecimal("ADBED2")
        case .gray_EAEAEA: return .hexadecimal("EAEAEA")

        // MARK: Pale Lilac
        case .paleLilac_E3E5EC: return .hexadecimal("E3E5EC")
        case .paleGrey_F2F3F9: return .hexadecimal("F2F3F9")

        // MARK: Primitive Color
        case .black: return .black
        case .white: return .white
        case .red: return .red
        case .green: return .green
        case .blue: return .blue
        }
    }
}

