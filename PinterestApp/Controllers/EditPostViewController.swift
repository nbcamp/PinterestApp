//
//  EditPostViewController.swift
//  PinterestApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/17.
//

import UIKit

// 이미지 뷰 클릭시 수정 페이지로 이동시키기
protocol EditPostViewControllerDelegate: class {
    func sendImage(_ imageString: UIImage) -> UIImage
}

class EditPostViewController: UIViewController {
    let picker = UIImagePickerController()
    let customScrollView = CustomScrollView()
    let customContentView = ContentView()
    var imageView = CustomImageView(image: nil)
    let customTextField = CustomTextField()
    let customTitleLable = CustomLabel()
    let customDetailLabel = CustomLabel()
    let customDetailTextView = CustomTextView()
    let editImageButton = CustomButton()
    let customUIBarButtonItem = CustomUIBarButtonItem()
    let customBackButton = CustomUIBarButtonItem()

    var galleryImage: UIImage?
    weak var delegate: EditPostViewControllerDelegate?

    let textViewPlaceHolder = "내용을 입력하세요."
    var textViewYValue = CGFloat(0)

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        customTextField.delegate = self
        customDetailTextView.delegate = self

        hideKeyboardWhenTappedAround()
        setupCustomNavigationBar()
        imageTapGesture()
        keyboardCheck()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        setupLayout()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        customTextField.becomeFirstResponder()
        customDetailTextView.becomeFirstResponder()
    }

    @objc func customBackbuttonAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        tabBarController?.selectedIndex = 0
    }

    @objc func imageViewClick(sender: UITapGestureRecognizer) {
        present(picker, animated: true)
    }

    @objc func tappedDoneButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        tabBarController?.selectedIndex = 0
    }

    private func imageTapGesture() {
        let imageClickTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageClickTapGesture)
    }

    private func setupCustomNavigationBar() {
        navigationItem.rightBarButtonItem = customUIBarButtonItem
        navigationItem.leftBarButtonItem = customBackButton

        customUIBarButtonItem.target = self
        customUIBarButtonItem.action = #selector(tappedDoneButton(_:))

        customBackButton.image = UIImage(systemName: "chevron.backward")
        customBackButton.target = self
        customBackButton.action = #selector(customBackbuttonAction(_:))
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        customDetailTextView.text = textViewPlaceHolder
        customDetailTextView.textColor = .lightGray

        picker.sourceType = .photoLibrary
        picker.allowsEditing = true

        imageView.image = galleryImage
        imageView.contentMode = .scaleToFill

        customTitleLable.text = "제목 입력"

        customTextField.placeholder = "텍스트를 입력하세요."

        customDetailLabel.text = "내용 입력"

        [customScrollView].forEach {
            view.addSubview($0)
        }

        [customContentView].forEach {
            customScrollView.addSubview($0)
        }

        customScrollView.addSubview(customContentView)
        [imageView, customTitleLable, customTextField, customDetailLabel, customDetailTextView].forEach {
            customContentView.addSubview($0)
        }
    }

    func setupLayout() {
        let layoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // 스크롤뷰
            customScrollView.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 0),
            customScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            customScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            customScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

            // 컨텐츠 뷰
            customContentView.topAnchor.constraint(equalTo: customScrollView.topAnchor),
            customContentView.leadingAnchor.constraint(equalTo: customScrollView.leadingAnchor),
            customContentView.trailingAnchor.constraint(equalTo: customScrollView.trailingAnchor),
            customContentView.bottomAnchor.constraint(equalTo: customScrollView.bottomAnchor),
            customContentView.widthAnchor.constraint(equalTo: customScrollView.widthAnchor),
            customContentView.heightAnchor.constraint(equalTo: customScrollView.heightAnchor),

            // 이미지 뷰
            imageView.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: customTitleLable.topAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: 390),
            imageView.heightAnchor.constraint(equalToConstant: 300),

            // 제목 입력 표시 라벨
            customTitleLable.centerXAnchor.constraint(equalTo: customScrollView.centerXAnchor),
            customTitleLable.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            customTitleLable.leadingAnchor.constraint(equalTo: customScrollView.leadingAnchor, constant: 40),
            customTitleLable.heightAnchor.constraint(equalToConstant: 40),

            // 제목 입력할 수 있는 텍스트 필드
            customTextField.centerXAnchor.constraint(equalTo: customScrollView.centerXAnchor),
            customTextField.topAnchor.constraint(equalTo: customTitleLable.bottomAnchor, constant: 5),
            customTextField.leadingAnchor.constraint(equalTo: customScrollView.leadingAnchor, constant: 40),
            customTextField.heightAnchor.constraint(equalToConstant: 60),

            // 내용 입력 표시 라벨
            customDetailLabel.centerXAnchor.constraint(equalTo: customScrollView.centerXAnchor),
            customDetailLabel.topAnchor.constraint(equalTo: customTextField.bottomAnchor, constant: 5),
            customDetailLabel.leadingAnchor.constraint(equalTo: customScrollView.leadingAnchor, constant: 40),
            customDetailLabel.heightAnchor.constraint(equalToConstant: 40),

            // 내용 입력할 수 있는 텍스트 뷰
            customDetailTextView.centerXAnchor.constraint(equalTo: customScrollView.centerXAnchor),
            customDetailTextView.topAnchor.constraint(equalTo: customDetailLabel.bottomAnchor, constant: 0),
            customDetailTextView.bottomAnchor.constraint(equalTo: customScrollView.bottomAnchor, constant: -10),
            customDetailTextView.leadingAnchor.constraint(equalTo: customScrollView.leadingAnchor, constant: 40),
            customDetailTextView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}

// MARK: - UITextFieldDelegate

extension EditPostViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        customTextField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        return true
    }
}

// MARK: - UITextViewDelegate

extension EditPostViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)

        let characterCount = newString.count
        guard characterCount <= 100 else { return false }

        return true
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if customDetailTextView.text == textViewPlaceHolder {
            customDetailTextView.text = nil
            customDetailTextView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if customDetailTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            customDetailTextView.text = textViewPlaceHolder
            customDetailTextView.textColor = .lightGray
        }
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        customDetailTextView.resignFirstResponder()
        return true
    }
}

// MARK: - hideKeyboardWhenTappedAround

extension EditPostViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(EditPostViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension EditPostViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        var newImage: UIImage? // update 할 이미지

        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            galleryImage = possibleImage // 원본 이미지가 있을 경우
        }

        imageView.image = newImage // 받아온 이미지를 update
        picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
    }
}

// MARK: - UINavigationControllerDelegate

extension EditPostViewController: UINavigationControllerDelegate {}

// MARK: - 키보드 올렸을 때 뷰 올리는 코드

extension EditPostViewController {
    func keyboardCheck() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        customScrollView.isScrollEnabled = false
        if customTextField.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if customContentView.frame.origin.y == textViewYValue {
                    customContentView.frame.origin.y -= keyboardSize.height / 3 - UIApplication.shared.windows.first!.safeAreaInsets.bottom
                }
            }
        } else if customDetailTextView.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if customContentView.frame.origin.y == textViewYValue {
                    customContentView.frame.origin.y -= keyboardSize.height * 1.2 - UIApplication.shared.windows.first!.safeAreaInsets.bottom
                }
            }
        }
    }

    @objc func keyboardDidShow(notification: NSNotification) {
        customScrollView.isScrollEnabled = false
        if customTextField.isFirstResponder {
            customDetailTextView.isEditable = false
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if customContentView.frame.origin.y == textViewYValue {
                    customContentView.frame.origin.y -= keyboardSize.height / 3 - UIApplication.shared.windows.first!.safeAreaInsets.bottom
                }
            }
        } else if customDetailTextView.isFirstResponder {
            customTextField.isEnabled = false
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if customContentView.frame.origin.y == textViewYValue {
                    customDetailTextView.frame.origin.y -= keyboardSize.height * 1.2 - UIApplication.shared.windows.first!.safeAreaInsets.bottom
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if customContentView.frame.origin.y != textViewYValue {
            customContentView.frame.origin.y = textViewYValue
            customScrollView.isScrollEnabled = true
            customDetailTextView.isEditable = true
            customTextField.isEnabled = true
        }
    }
}
