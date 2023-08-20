import UIKit

final class Medium {
    var image: UIImage

    var title: String?
    var description: String?

    var width: Double
    var height: Double

    init(image: UIImage, width: Double, height: Double, title: String? = nil, description: String? = nil) {
        self.image = image
        self.title = title
        self.description = description
        self.width = width
        self.height = height
    }
}
