//
//  SigninViewModel.swift
//  Roompi
//
//  Created by irwan on 02/02/21.
//

import Foundation
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
  var accountInfo: Observable<SignInModel> { get }
  var login: Driver<Bool> { get }
}

final class SigninViewModel: SigninViewModelType {
    let disposableBag = DisposeBag()
    var inputs: SigninViewModelInputs { self }
    var outputs: SigninViewModelOutputs { self }
    private var accountSubject: PublishSubject<SignInModel> = .init()
    var isSuccessRelay: BehaviorRelay<Bool> = .init(value: false)

}

extension SigninViewModel: SigninViewModelInputs {

  func signRequest(userName: String, password: String) {
      Signin.signInPosts(userName: userName, password: password)
        .observe(on: MainScheduler.instance)
        .subscribe(onNext:{ [self] response in
          print("List of response:", response.result.token)
          isSuccessRelay.accept(true)
        })
        .disposed(by: disposableBag)
    }
}

extension SigninViewModel: SigninViewModelOutputs {
  var login: Driver<Bool> {
    isSuccessRelay.asDriver()
  }
  
  var accountInfo: Observable<SignInModel> {
    accountSubject.asObservable()
  }

}

