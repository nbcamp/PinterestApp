import UIKit

class ViewController: UIViewController {
    let label = {
        let label = UILabel()
        label.text = "Hello, World!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
    }

    func initializeUI() {
        view.backgroundColor = .secondarySystemBackground

        view.addSubview(label)

        let layout = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: layout.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: layout.centerYAnchor),
        ])
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct PreView: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
    }
}
#endif
