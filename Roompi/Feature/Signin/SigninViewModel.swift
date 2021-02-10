//
//  SigninViewModel.swift
//  Roompi
//
//  Created by irwan on 02/02/21.
//

import RxSwift
import RxCocoa

protocol SigninViewModelType {
    var inputs: SigninViewModelInputs { get }
    var outputs: SigninViewModelOutputs { get }
}

protocol SigninViewModelInputs {
    func signRequest(userName: String, password: String)
}

protocol SigninViewModelOutputs {
//  var profileInfo: Observable<UserProfile?> { get }
}

final class SigninViewModel: SigninViewModelType {
    let disposableBag = DisposeBag()
    var inputs: SigninViewModelInputs { self }
    var outputs: SigninViewModelOutputs { self }

}

extension SigninViewModel: SigninViewModelInputs {

  func signRequest(userName: String, password: String) {
      Signin.signInPosts(userName: userName, password: password)
        .observe(on: MainScheduler.instance)
        .subscribe(onNext:{ response in
          print("List of response:", response.message)
        })
        .disposed(by: disposableBag)
    }
}

extension SigninViewModel: SigninViewModelOutputs {
//  var profileInfo: Observable<UserProfile?> {
//    <#code#>
//  }
}
