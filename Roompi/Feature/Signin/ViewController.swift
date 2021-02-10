//
//  ViewController.swift
//  Roompi
//
//  Created by irwan on 01/02/21.
//

import UIKit

class ViewController: UIViewController {

    private let viewModel: SigninViewModelType = SigninViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputs.signRequest(userName: "Iyon", password: "test321")
    }


}

