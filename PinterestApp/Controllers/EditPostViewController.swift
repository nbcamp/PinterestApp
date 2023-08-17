//
//  EditPostViewController.swift
//  PinterestApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/17.
//

import UIKit

// 이미지 뷰 클릭시 수정 페이지로 이동시키기
protocol SendImage {
    func sendImage(_ imageString: UIImage) -> UIImage
}

class EditPostViewController: UIViewController {
    let customScrollView = CustomScrollView()
    let customContentView = ContentView()
    let imageView = CustomImageView(image: nil)
    let customTextField = CustomTextField()
    let customTitleLable = CustomLabel()
    let customDetailLabel = CustomLabel()
    let customDetailTextView = CustomTextView()
    let editImageButton = CustomButton()
    let customUIBarButtonItem = CustomUIBarButtonItem()

    var galleryImage: UIImage?
    var delegate: SendImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "두번째"
        view.backgroundColor = .systemOrange
        customTextField.delegate = self
        hideKeyboardWhenTappedAround()
    }

    override func viewWillAppear(_ animated: Bool) {
        print("새로 시작함")
        setupUI()
        setupLayout()
        customTextField.becomeFirstResponder()
    }

    @objc func tappedDoneButton(_ sender: UIBarButtonItem) {
        print("완료 눌렀다.")
    }

    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = customUIBarButtonItem
        customUIBarButtonItem.target = self
        customUIBarButtonItem.action = #selector(tappedDoneButton(_:))

        imageView.image = galleryImage
        imageView.contentMode = .scaleAspectFit

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
            customScrollView.heightAnchor.constraint(equalToConstant: 1000),

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
            imageView.heightAnchor.constraint(equalToConstant: 300),

            // 제목 입력 표시 라벨
            customTitleLable.centerXAnchor.constraint(equalTo: customScrollView.centerXAnchor),
            customTitleLable.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            customTitleLable.leadingAnchor.constraint(equalTo: customScrollView.leadingAnchor, constant: 40),
            customTitleLable.heightAnchor.constraint(equalToConstant: 60),

            // 제목 입력할 수 있는 텍스트 필드
            customTextField.centerXAnchor.constraint(equalTo: customScrollView.centerXAnchor),
            customTextField.topAnchor.constraint(equalTo: customTitleLable.bottomAnchor, constant: 5),
            customTextField.leadingAnchor.constraint(equalTo: customScrollView.leadingAnchor, constant: 40),
            customTextField.heightAnchor.constraint(equalToConstant: 60),

            // 내용 입력 표시 라벨
            customDetailLabel.centerXAnchor.constraint(equalTo: customScrollView.centerXAnchor),
            customDetailLabel.topAnchor.constraint(equalTo: customTextField.bottomAnchor, constant: 5),
            customDetailLabel.leadingAnchor.constraint(equalTo: customScrollView.leadingAnchor, constant: 40),
            customDetailLabel.heightAnchor.constraint(equalToConstant: 60),

            // 내용 입력할 수 있는 텍스트 뷰
            customDetailTextView.centerXAnchor.constraint(equalTo: customScrollView.centerXAnchor),
            customDetailTextView.topAnchor.constraint(equalTo: customDetailLabel.bottomAnchor, constant: 0),
            customDetailTextView.bottomAnchor.constraint(equalTo: customScrollView.bottomAnchor, constant: -30),
            customDetailTextView.leadingAnchor.constraint(equalTo: customScrollView.leadingAnchor, constant: 40),
            customDetailTextView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}

extension EditPostViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        customTextField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        return true
    }
}

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
