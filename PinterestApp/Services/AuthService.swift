import Foundation

final class AuthService {
    static let shared: AuthService = .init()
    private init() {}

    func getUserInfo(completion: @escaping (User?) -> Void) {
        let userInfo = User(name: "SJ", introduce: "Hello")
        completion(userInfo)
    }

    func updateUserInfo(userInfo: User, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}

//로그인 사용자 정보 저장
//-> 기능: 로그인, 로그아웃, 사용자정보 업뎃
