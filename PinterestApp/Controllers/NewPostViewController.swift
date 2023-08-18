import UIKit

final class NewPostViewController: UIViewController {
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        picker.delegate = self
        settingPicker()
    }

    func settingPicker() {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
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
extension NewPostViewController: EditPostViewControllerDelegate {
    func sendImage(_ imageString: UIImage) -> UIImage {
        return imageString
    }
}

extension NewPostViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let vc = EditPostViewController()
        vc.delegate = self

        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            vc.galleryImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            vc.galleryImage = possibleImage // 원본 이미지가 있을 경우
        }
        navigationController?.pushViewController(vc, animated: true)
        picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        tabBarController?.selectedIndex = 0
    }
}

extension NewPostViewController: UINavigationControllerDelegate {}
