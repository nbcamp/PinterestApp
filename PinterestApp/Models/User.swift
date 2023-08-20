import UIKit

final class User {
    var avatar: UIImage?
    var name: String?
    var introduce: String?
}

extension User: CustomDebugStringConvertible {
    var debugDescription: String {
        return """
        User(
            avatar: \(avatar.debugDescription),
            name: \(name ?? "Unnamed"),
            introduce: \(introduce ?? "")
        )
        """
    }
}
