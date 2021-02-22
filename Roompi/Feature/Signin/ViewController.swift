//
//  ViewController.swift
//  Roompi
//
//  Created by irwan on 01/02/21.
//

import UIKit

class ViewController: BaseViewController {

  @IBOutlet weak var scrollView: UIScrollView!
  private let viewModel: SigninViewModelType = SigninViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    registerKeyboardNotifications()
    viewModel.inputs.signRequest(userName: "Iyon", password: "test321")
  }


  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }

  
}

