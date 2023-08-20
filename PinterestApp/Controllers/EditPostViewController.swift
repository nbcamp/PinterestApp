//
//  EditPostViewController.swift
//  PinterestApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/17.
//

import UIKit

// 이미지 뷰 클릭시 수정 페이지로 이동시키기
protocol EditPostViewControllerDelegate: AnyObject {
    func sendImage(_ imageString: UIImage) -> UIImage
}

class EditPostViewController: UIViewController {
    var galleryImage: UIImage?
    weak var delegate: EditPostViewControllerDelegate?

    private let picker = UIImagePickerController()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var imageView = UIImageView()

    private let titleLabel = UILabel()
    private let titleTextField = CustomTextField()

    private let detailLabel = UILabel()
    private let detailTextView = CustomTextView()

    private let doneButton = UIBarButtonItem()
    private let backButton = UIBarButtonItem()

    private let titlePlaceholder = "제목을 입력해주세요."
    private let detailPlaceholder = "설명을 입력해주세요."
    private var textFieldPosY = CGFloat(0)

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        titleTextField.delegate = self
        detailTextView.delegate = self

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
        titleTextField.becomeFirstResponder()
        detailTextView.becomeFirstResponder()
    }

    @objc func backButtonAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        tabBarController?.selectedIndex = 0
    }

    @objc func imageViewClick(sender: UITapGestureRecognizer) {
        present(picker, animated: true)
    }

    @objc func tappedDoneButton(_ sender: UIBarButtonItem) {
        if let image = imageView.image {
            MediumService.shared.create(medium: .init(
                image: image,
                width: image.size.width,
                height: image.size.height,
                title: titleTextField.text,
                description: detailTextView.text
            ))
        }
        navigationController?.popViewController(animated: true)
        tabBarController?.selectedIndex = 0
    }

    private func imageTapGesture() {
        let imageClickTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageClickTapGesture)
    }

    private func setupCustomNavigationBar() {
        doneButton.title = "Done"

        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = backButton

        doneButton.target = self
        doneButton.action = #selector(tappedDoneButton(_:))

        backButton.image = UIImage(systemName: "chevron.backward")
        backButton.target = self
        backButton.action = #selector(backButtonAction(_:))
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        picker.sourceType = .photoLibrary
        picker.allowsEditing = true

        imageView.image = galleryImage
        imageView.contentMode = .scaleToFill

        titleLabel.text = "제목"
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleTextField.placeholder = titlePlaceholder

        detailLabel.text = "설명"
        detailLabel.font = .boldSystemFont(ofSize: 16)
        detailTextView.text = detailPlaceholder
        detailTextView.textColor = .systemGray2

        [scrollView].forEach {
            view.addSubview($0)
        }

        [contentView].forEach {
            scrollView.addSubview($0)
        }

        scrollView.addSubview(contentView)
        [imageView, titleLabel, titleTextField, detailLabel, detailTextView].forEach {
            contentView.addSubview($0)
        }
    }

    func setupLayout() {
        [scrollView, contentView, imageView, titleLabel, titleTextField, detailLabel, detailTextView].forEach { removeDefaultConstraints(view: $0) }

        let layoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // 스크롤뷰
            scrollView.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

            // 컨텐츠 뷰
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),

            // 이미지 뷰
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: 390),
            imageView.heightAnchor.constraint(equalToConstant: 300),

            // 제목 입력 표시 라벨
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),

            // 제목 입력할 수 있는 텍스트 필드
            titleTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            titleTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            titleTextField.heightAnchor.constraint(equalToConstant: 60),

            // 내용 입력 표시 라벨
            detailLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            detailLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            detailLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            detailLabel.heightAnchor.constraint(equalToConstant: 40),

            // 내용 입력할 수 있는 텍스트 뷰
            detailTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            detailTextView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 0),
            detailTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            detailTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            detailTextView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}

// MARK: - UITextFieldDelegate

extension EditPostViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
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
        if detailTextView.text == detailPlaceholder {
            detailTextView.text = nil
            detailTextView.textColor = .label
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if detailTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            detailTextView.text = detailPlaceholder
            detailTextView.textColor = .systemGray2
        }
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        detailTextView.resignFirstResponder()
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
        scrollView.isScrollEnabled = false
        if titleTextField.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if contentView.frame.origin.y == textFieldPosY {
                    contentView.frame.origin.y -= keyboardSize.height / 3 - UIApplication.shared.windows.first!.safeAreaInsets.bottom
                }
            }
        } else if detailTextView.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if contentView.frame.origin.y == textFieldPosY {
                    contentView.frame.origin.y -= keyboardSize.height * 1.2 - UIApplication.shared.windows.first!.safeAreaInsets.bottom
                }
            }
        }
    }

    @objc func keyboardDidShow(notification: NSNotification) {
        scrollView.isScrollEnabled = false
        if titleTextField.isFirstResponder {
            detailTextView.isEditable = false
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if contentView.frame.origin.y == textFieldPosY {
                    contentView.frame.origin.y -= keyboardSize.height / 3 - UIApplication.shared.windows.first!.safeAreaInsets.bottom
                }
            }
        } else if detailTextView.isFirstResponder {
            titleTextField.isEnabled = false
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if contentView.frame.origin.y == textFieldPosY {
                    detailTextView.frame.origin.y -= keyboardSize.height * 1.2 - UIApplication.shared.windows.first!.safeAreaInsets.bottom
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if contentView.frame.origin.y != textFieldPosY {
            contentView.frame.origin.y = textFieldPosY
            scrollView.isScrollEnabled = true
            detailTextView.isEditable = true
            titleTextField.isEnabled = true
        }
    }
}
