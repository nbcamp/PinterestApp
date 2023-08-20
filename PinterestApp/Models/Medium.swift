import UIKit

final class Medium {
    var image: UIImage

    var title: String?
    var caption: String?

    var width: Double
    var height: Double

    weak var author: User?

    init(image: UIImage, width: Double, height: Double, author: User? = nil, title: String? = nil, caption: String? = nil) {
        self.image = image
        self.width = width
        self.height = height
        self.author = author
        self.title = title
        self.caption = caption
    }
}
