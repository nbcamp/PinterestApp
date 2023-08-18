import UIKit

final class EditProfileViewController: UIViewController {
    private var loadingView: UIView?
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()

    let imageView: UIImageView = {
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
    
    lazy var imagePickerController = UIImagePickerController()
    
    let changeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change", for: .normal)
        button.addTarget(self, action: #selector(changeButtonTap), for: .touchUpInside)
        button.setTitleColor(.label, for: .normal)
        
        return button
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Name"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.textColor = .label
        
        return nameLabel
    }()
    
    let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "name"
        textField.font = UIFont.systemFont(ofSize: 19)
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 13.0
        
        return textField
    }()

    let introduceLabel: UILabel = {
        let introduceLabel = UILabel()
        introduceLabel.translatesAutoresizingMaskIntoConstraints = false
        introduceLabel.text = "Introduce"
        introduceLabel.font = UIFont.boldSystemFont(ofSize: 15)
        introduceLabel.textColor = .label
        
        return introduceLabel
    }()
    
    private lazy var introduceTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Introduce"
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 15.0
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 5, bottom: 12, right: 5)
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
    }

    private func addNavButtons() {
        let leftButton = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(backButtonTap))
        let rightButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTap))
        leftButton.tintColor = UIColor.label
        rightButton.tintColor = UIColor.label
        navigationItem.leftBarButtonItem = leftButton
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
      
        contentView.addSubview(imageView)
        contentView.addSubview(changeButton)
        contentView.addSubview(nameLabel)
        contentView.addSubview(firstNameTextField)
        contentView.addSubview(introduceLabel)
        contentView.addSubview(introduceTextView)
    }
    
    @objc func backButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func doneButtonTap(_sender: Any) {
        showLoadingScreen()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.dismissLoadingScreen()
        }
    }

    @objc func changeButtonTap() {
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
    
    // 레이아웃
    private func setUpConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
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
            
            // 프로필 이미지뷰
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40.0),
            
            // 프로필 사진 변경 버튼
            changeButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 14.0),
            changeButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // name 라벨
            nameLabel.topAnchor.constraint(equalTo: changeButton.bottomAnchor, constant: 15.0),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35.0),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30.0),
            nameLabel.heightAnchor.constraint(equalToConstant: 25.0),
            
            // first name 텍스트 필드
            firstNameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12.0),
            firstNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30.0),
            firstNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30.0),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 40.0),
        
            // introduce 라벨
            introduceLabel.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 30.0),
            introduceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35.0),
            introduceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30.0),
            introduceLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            // introduce 텍스트 뷰
            introduceTextView.topAnchor.constraint(equalTo: introduceLabel.bottomAnchor, constant: 12.0),
            introduceTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30.0),
            introduceTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30.0),
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
        guard introduceTextView.textColor == .placeholderText else { return }
        introduceTextView.textColor = .label
        introduceTextView.text = nil
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if introduceTextView.text.isEmpty {
            introduceTextView.text = "introduce"
            introduceTextView.textColor = .placeholderText
        }
    }
}
