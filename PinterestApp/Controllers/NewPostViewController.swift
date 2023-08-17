import UIKit

final class NewPostViewController: UIViewController {
    let picker = UIImagePickerController()

    var galleryImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "첫번째"
        initializeUI()
        picker.delegate = self
    }

    private func initializeUI() {
        view.backgroundColor = .systemBackground

        let button = {
            let button = UIButton()
            button.setTitle("New Post View : Button", for: .normal)
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
        let vc = EditPostViewController()
        openLibrary()
    }

    func openLibrary() {
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true)
    }
}

// 2번째 페이지로 이미지를 전달할 프로토콜
extension NewPostViewController: SendImage {
    func sendImage(_ imageString: UIImage) -> UIImage {
        return imageString
    }
}

extension NewPostViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            galleryImage = image

            let vc = EditPostViewController()
            vc.delegate = self

            DispatchQueue.main.async {
                vc.galleryImage = self.galleryImage
            }

            dismiss(animated: true, completion: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension NewPostViewController: UINavigationControllerDelegate {}
