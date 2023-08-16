import UIKit

final class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
    }

    private func initializeUI() {
        view.backgroundColor = .systemBackground

        let button = {
            let button = UIButton()
            button.setTitle("Home View : Button", for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        view.addSubview(button)

        let layout = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: layout.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: layout.centerYAnchor),
        ])
    }

    @objc
    private func buttonTapped() {
        navigationController?.pushViewController(DetailPostViewController(), animated: true)
    }
}
