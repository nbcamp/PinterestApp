import Foundation

final class AuthService {
    static let shared: AuthService = .init()
    private init() {}

    private(set) var user: User?

    func login(completion: ((User) -> Void)? = nil) {
        // 서버 로그인 요청 후 사용자 정보 생성
        let user = User()
        user.name = "User 1"
        user.introduce = "테스트 생성 계정입니다."
        self.user = user
        completion?(user)
    }

    func update(user: User, completion: ((User) -> Void)? = nil) {
        // 서버 사용자 정보 변경 요청 후 사용자 반환
        self.user = user
        completion?(user)
    }
}
