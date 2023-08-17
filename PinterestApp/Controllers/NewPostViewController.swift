import UIKit

final class NewPostViewController: UIViewController {
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "첫번째"
        view.backgroundColor = .systemBackground
        picker.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
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
            let vc = EditPostViewController()
            vc.delegate = self
            vc.galleryImage = image

            navigationController?.pushViewController(vc, animated: true)
        }
        dismiss(animated: true, completion: nil)
    }
}

extension NewPostViewController: UINavigationControllerDelegate {}
