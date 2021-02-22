//
//  BaseTextField.swift
//  Roompi
//
//  Created by irwan on 10/02/21.
//

import UIKit
import Material
import SnapKit
import RxSwift
import RxCocoa

final class BaseTextField: ErrorTextField {
    enum AccessoryType: Int {
        case prev = -1
        case next = 1
        case done = 0
    }

    enum Constant {
        // when you change below values, please discuss with others
      static let height: CGFloat = 70
      static let textTopInset: CGFloat = 30
      static let placeholderTopInset: CGFloat = 32
      static let clearButtonTopInset: CGFloat = 12.5
      static let clearButtonLeftInset: CGFloat = 8
      static let defaultPlaceholderHeight: CGFloat = 34
    }

    @IBInspectable var hideClearButton: Bool = false {
        didSet {
            clearButtonMode = hideClearButton ? .never : .whileEditing
            rightViewMode = hideClearButton ? .never : .whileEditing
        }
    }

    @IBInspectable var isDisabledCopyAndPaste: Bool = false
    @IBInspectable var isEnableDone: Bool = false
    @IBInspectable var isEnableNext: Bool = false
    @IBInspectable var isEnablePrev: Bool = false
    @IBInspectable var hasStaticHeight: Bool = false {
        didSet {
            guard hasStaticHeight else { return }
            snp.remakeConstraints {
                $0.height.equalTo(Constant.height)
            }

            textInsets.top = Constant.textTopInset
            placeholderVerticalOffset = Constant.placeholderTopInset
        }
    }
    @IBInspectable var textVerticalOffset: CGFloat = 0
    @IBInspectable var maximumLength: Int = -1

    var allowedTextOptions: TextOptions = [] {
        didSet {
            if allowedTextOptions == .realNamePolicy {
                maximumLength = 50
            }
        }
    }
    private let isTextFilledSubject: PublishSubject<Bool> = .init()
    var isTextFilled: Observable<Bool> {
        isTextFilledSubject.asObservable()
    }

    var accessoryAction: Observable<AccessoryType> {
        accessoryActionSubject.asObservable()
    }
    private let accessoryActionSubject: PublishSubject<AccessoryType> = .init()

    private var disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonJob()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonJob()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonJob()
    }

    func commonJob() {
        prepareUI()
        prepareAccessoryView()
        setupViews()
        bindViewModel()
    }

    func attach() {
        self.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.top.equalToSuperview().inset(26)
            $0.bottom.equalToSuperview().inset(25)
        }
    }

    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.clearButtonRect(forBounds: bounds)
        guard hasStaticHeight else { return originalRect }
        return originalRect.offsetBy(dx: Constant.clearButtonLeftInset, dy: Constant.clearButtonTopInset)
    }

    override func layoutSubviews() {
        textInsets.top = Constant.textTopInset
            + ((isEditing || !isEmpty || !isPlaceholderAnimated) ? -5 : 0)
            + textVerticalOffset

        super.layoutSubviews()

        if isErrorRevealed {
            dividerActiveColor = UIColor.hexadecimal(0xd93e3e)
            dividerNormalColor = UIColor.hexadecimal(0xd93e3e)
            dividerActiveHeight = 2
            dividerNormalHeight = 1
        } else {
          dividerActiveColor = .style(.blue_A2D6F5)
            dividerNormalColor = .style(.gray_ECECEC)
            dividerActiveHeight = 2
            dividerNormalHeight = 1
        }
    }

    private func prepareUI() {
        textInsets.top += textVerticalOffset
        textInsets.bottom -= textVerticalOffset

        autocapitalizationType = .none
        clearButtonMode = hideClearButton ? .never : .whileEditing
        rightView = nil

        font = .style(.subtitle3())
        dividerActiveColor = .style(.orange_FF7E4B)
        dividerNormalColor = .style(.gray_ECECEC)
        dividerActiveHeight = 2
        dividerNormalHeight = 1

        placeholderActiveScale = 0.67
        placeholderActiveColor = .style(.gray_C1C1C1)
        placeholderNormalColor = .style(.gray_C1C1C1)

        placeholderLabel.font = .style(.subtitle3())
        placeholderLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: Constant.defaultPlaceholderHeight)
        placeholderLabel.numberOfLines = 1

        errorLabel.font = .style(.body5())
        errorColor = UIColor.hexadecimal(0xf24646)
        errorLabel.numberOfLines = 1
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.minimumScaleFactor = 0.7
        errorLabel.clipsToBounds = false
        errorVerticalOffset = 4

        detailColor = .style(.gray_97999E)
        detailLabel.numberOfLines = 0
        detailLabel.font = .style(.body5(.bold))
        detailVerticalOffset = 4
    }

    override func bindViewModel() {
        rx.text.orEmpty.changed
            .compactMap { [weak self] _ in
                self?.allowedTextOptions.regex
            }
            .bind(onNext: { [weak self] regex in
                self?.text = self?.text?.stringByReplacingMatches(regex: regex, options: [], withTemplate: "")
            }).disposed(by: disposeBag)

        rx.text.orEmpty
            .scan("") { [weak self] in
                guard let self = self else { return nil }

                if self.maximumLength < 0 {
                    self.isTextFilledSubject.onNext(true)
                    return $1
                }

                if $1.count >= self.maximumLength {
                    self.isTextFilledSubject.onNext(true)
                    return String($1.prefix(self.maximumLength))
                } else {
                    self.isTextFilledSubject.onNext(false)
                    return $1
                }
            }.subscribe(rx.text)
            .disposed(by: disposeBag)
    }

    private func prepareAccessoryView() {
        guard isEnablePrev || isEnableNext || isEnableDone else { return }

        inputAccessoryView = UIToolbar().apply {
            let accessoryViews: ([UIBarButtonItem], [Observable<AccessoryType>]) = run {
                var accessoryViews: ([UIBarButtonItem], [Observable<AccessoryType>]) = ([], [])

                if isEnablePrev {
                    let prev = UIBarButtonItem(image: UIImage(named: "icArrowup"), style: .plain, target: self, action: nil)
                    accessoryViews.0.append(prev)
//                    accessoryViews.1.append(prev.rx.tap.mapTo(.prev))
                }

                if isEnableNext {
                    let next = UIBarButtonItem(image: UIImage(named: "icArrowDown"), style: .plain, target: self, action: nil)
                    accessoryViews.0.append(next)
//                    accessoryViews.1.append(next.rx.tap.mapTo(.next))
                }

                accessoryViews.0.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))

                if isEnableDone {
                    let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
                    done.setTitleTextAttributes([
                        .foregroundColor: UIColor.style(.black_222222),
                        NSAttributedString.Key.font: UIFont.style(.subtitle4(.semibold))
                    ], for: .normal)

                    accessoryViews.0.append(done)
//                    accessoryViews.1.append(done.rx.tap.mapTo(.done))
                }

                return accessoryViews
            }

            $0.sizeToFit()
            $0.items = accessoryViews.0

            Observable<AccessoryType>.merge(accessoryViews.1)
//                .throttle()
                .bind(to: accessoryActionSubject)
                .disposed(by: disposeBag)
        }
    }

    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                becomeFirstResponder()
            }
        }
    }

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            deleteBackward()
            insertText(text)
        }
        return success
    }

    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if isDisabledCopyAndPaste {
            return false
        }

        return super.canPerformAction(action, withSender: sender)
    }
}

extension BaseTextField {
    func clear() {
        text = ""
        sendActions(for: .editingChanged)
    }
}

extension Reactive where Base: BaseTextField {
    /// Check validation
    /// - Parameter pattern: Regular expression format string
    /// - Returns: isValid as Driver<Bool>
    func isValid(pattern: String) -> Driver<Bool> {
        base.rx.text.changed
            .map { [weak base] text -> Bool in
                guard let base = base else { return true }
                guard pattern.isNotEmpty else { return true }
                guard let text = base.text, text.isNotEmpty else {
                    return false
                }
                guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
                    print("format[\(pattern)] is not valid regex")

                    return false
                }

                let range = NSRange(location: 0, length: text.count)

                return regex.rangeOfFirstMatch(in: text, options: [], range: range) == range
            }
            .asDriver(onErrorJustReturn: false)
    }

    func validate(pattern: String) -> Driver<String?> {
        base.rx.isValid(pattern: pattern).map { [weak base] in $0 ? base?.text : nil }
    }

    var isSecureTextEntry: Binder<Bool> {
        Binder(self.base) { textField, isSecureTextEntry in
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }
}

