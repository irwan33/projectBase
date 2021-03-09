//
//  ViewController.swift
//  Roompi
//
//  Created by irwan on 01/02/21.
//

import UIKit
import RxSwift

class ViewController: BaseViewController {

  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var LoginButton: UIButton!
  @IBOutlet weak var imageBackground: UIImageView!
  @IBOutlet weak var LogoImage: UIImageView!
  private let viewModel: SigninViewModelType = SigninViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    keyboardNotifications()
    binUI()
    bindData()
    bindAction()

  }

  func binUI() {
    imageBackground.image = UIImage(named: "splashScreen")
  }

  func bindData() {
    viewModel.outputs.login
      .drive(onNext: { _ in
        self.goToHome()
    })
      .disposed(by: disposeBag)
  }

  func bindAction() {
    LoginButton.rx.tap
      .bind(onNext: { [weak self] _ in
          guard let self = self else { return }
          self.viewModel.inputs.signRequest(userName: "Iyon", password: "test321")
      }).disposed(by: disposeBag)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
}

private extension ViewController {
  private func goToHome() {
    print("goToHome")
  }
}
