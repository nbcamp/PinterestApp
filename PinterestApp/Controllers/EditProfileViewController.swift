import UIKit

final class EditProfileViewController: UIViewController {
    private var loadingView: UIView?
    
    private let namePlaceholder = "이름을 작성해주세요."
    private let introducePlaceholder = "자기소개글을 작성해주세요."
   
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let contentView: UIStackView = {
        let contentView = UIStackView()
        contentView.axis = .vertical
        contentView.spacing = 20
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "default_profile")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 75
        imageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowColor = UIColor.black.cgColor
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var imagePickerController = UIImagePickerController()
    
    private lazy var changeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change", for: .normal)
        button.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        button.setTitleColor(.label, for: .normal)
        
        return button
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "이름"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textColor = .label
        
        return nameLabel
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = self.namePlaceholder
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 10.0
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        
        return textField
    }()

    private let introduceLabel: UILabel = {
        let introduceLabel = UILabel()
        introduceLabel.translatesAutoresizingMaskIntoConstraints = false
        introduceLabel.text = "자기소개"
        introduceLabel.font = UIFont.boldSystemFont(ofSize: 16)
        introduceLabel.textColor = .label
        
        return introduceLabel
    }()
    
    private lazy var introduceTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = introducePlaceholder
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 10.0
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.textColor = .placeholderText
        
        textView.delegate = self
        
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeUI()
        
        addNavButtons()
        setUpImagePickerController()
        setUpViews()
        setUpConstraints()
        
        nameTextField.delegate = self
        introduceTextView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func addNavButtons() {
        let rightButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        rightButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = rightButton
              
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 21),
            .foregroundColor: UIColor.label,
        ]
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        navigationItem.title = "Edit profile"
    }
    
    private func initializeUI() {
        view.backgroundColor = .systemBackground
        scrollView.alwaysBounceVertical = true
    }

    private func setUpImagePickerController() {
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
    }
    
    private func setUpViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let imageStackView = UIStackView(arrangedSubviews: [imageView, changeButton])
        imageStackView.axis = .vertical
        imageStackView.spacing = 10
        contentView.addArrangedSubview(imageStackView)
                
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        nameStackView.axis = .vertical
        nameStackView.spacing = 10
        contentView.addArrangedSubview(nameStackView)
                
        let introduceStackView = UIStackView(arrangedSubviews: [introduceLabel, introduceTextView])
        introduceStackView.axis = .vertical
        introduceStackView.spacing = 10
        contentView.addArrangedSubview(introduceStackView)
    }

    @objc func doneButtonTapped(_sender: Any) {
        showLoadingScreen()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.dismissLoadingScreen()
        }
    }

    @objc func changeButtonTapped() {
        present(imagePickerController, animated: true, completion: nil)
    }

    private func showLoadingScreen() {
        let loadingView = UIView(frame: view.bounds)
        loadingView.backgroundColor = .white
        loadingView.alpha = 0.6
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = loadingView.center
        activityIndicator.startAnimating()
        
        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)
        
        self.loadingView = loadingView
    }
    
    private func dismissLoadingScreen() {
        guard let loadingView = loadingView else {
            return
        }
        
        loadingView.removeFromSuperview()
        
        self.loadingView = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.becomeFirstResponder()
        introduceTextView.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideKeyboardTappedAround()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let desiredKeyboardHeight: CGFloat = keyboardHeight
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: desiredKeyboardHeight, right: 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    // 레이아웃
    private func setUpConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        imageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 100.0).isActive = true
        imageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -100.0).isActive = true
        changeButton.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 30.0).isActive = true
        changeButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -30.0).isActive = true

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40.0),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            changeButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            changeButton.widthAnchor.constraint(equalToConstant: 100),
            changeButton.heightAnchor.constraint(equalToConstant: 30),
            
            nameLabel.topAnchor.constraint(equalTo: changeButton.bottomAnchor, constant: 60.0),
            nameLabel.heightAnchor.constraint(equalToConstant: 20.0),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            nameTextField.heightAnchor.constraint(equalToConstant: 40.0),
            
            introduceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            introduceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            introduceLabel.heightAnchor.constraint(equalToConstant: 20.0),
                        
            introduceTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            introduceTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            introduceTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50.0),
            introduceTextView.heightAnchor.constraint(equalToConstant: 220.0),
            
        ])
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        var selectedImage: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        if let image = selectedImage {
            imageView.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EditProfileViewController: UINavigationControllerDelegate {
    //
}
    
extension EditProfileViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard introduceTextView.text == introducePlaceholder else { return }
        introduceTextView.textColor = .label
        introduceTextView.text = nil
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if introduceTextView.text.isEmpty {
            introduceTextView.text = introducePlaceholder
            introduceTextView.textColor = .placeholderText
        }
    }
}

extension EditProfileViewController {
    func hideKeyboardTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(EditProfileViewController
                .dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    func textFieldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        introduceTextView.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        return true
    }
}
