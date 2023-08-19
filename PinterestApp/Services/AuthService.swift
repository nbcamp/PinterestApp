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
