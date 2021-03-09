
import Foundation
import RxSwift
import RxCocoa

class Signin: ApiClient {

  static func signInPosts(userName: String, password: String) -> Observable<SignInModel> {
      let url = "https://api.roompi.io/user/login"
      let params = ["username": userName, "password": password]
      return request(url, method: .post, parameters: params)
  }
}

