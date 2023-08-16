import UIKit

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
    }

    private func initializeUI() {
        view.backgroundColor = .secondarySystemBackground

        let button = {
            let button = UIButton()
            button.setTitle("Button", for: .normal)
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
        print("화면 전환 테스트 코드가 필요하다면 여기 작성하세요.")
        print("Commit하지 않도록 주의하세요.")
    }
}
