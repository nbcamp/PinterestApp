import UIKit

class ViewController: UIViewController {
    // 네비게이션 바
    let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        return navigationBar
    }()
    
    // 프로필 이미지 설정
    let imageView: UIImageView = {
        let aImageView = UIImageView()
        aImageView.backgroundColor = .white
        aImageView.image = UIImage(named: "Idontknow")
        aImageView.contentMode = .scaleAspectFill
        aImageView.layer.cornerRadius = 75
        aImageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        aImageView.layer.shadowOpacity = 0.7
        aImageView.layer.shadowRadius = 5
        aImageView.layer.shadowColor = UIColor.gray.cgColor
        
        aImageView.translatesAutoresizingMaskIntoConstraints = false
        aImageView.clipsToBounds = true
        
        return aImageView
    }()
    
    // 이미지선택 UIImagePickerController 생성
    let imagePickerController = UIImagePickerController()
    
    // change 버튼 설정
    let changeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change", for: .normal)
        button.addTarget(self, action: #selector(changeButtonTap), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    // name 라벨
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Name"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.textColor = .black
        
        return nameLabel
    }()
    
    //  name 텍스트필드
    let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "name"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.borderStyle = .roundedRect
        // textField.layer.cornerRadius = 20.0
        
        return textField
    }()
   
    // intoduce 라벨
    let introduceLabel: UILabel = {
        let introduceLabel = UILabel()
        introduceLabel.translatesAutoresizingMaskIntoConstraints = false
        introduceLabel.text = "Introduce"
        introduceLabel.font = UIFont.boldSystemFont(ofSize: 15)
        introduceLabel.textColor = .black
        
        return introduceLabel
    }()
    
    // introduce 텍스트뷰
    let introduceTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "bulabula..."
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 15.0
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
        
        view.backgroundColor = .white
        
        //
        if let savedName = UserDefaults.standard.string(forKey: "userName") {
            firstNameTextField.text = savedName
        }
        
        //
        if let savedIntroduce = UserDefaults.standard.string(forKey: "introduce") {
            introduceTextView.text = savedIntroduce
        }
        
        // 네비게이션 바 설정
        let navItem = UINavigationItem(title: "Edit profile")
        let leftButton = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(backButtonTap))
        let rightButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTap))
        leftButton.tintColor = UIColor.black
        rightButton.tintColor = UIColor.black
        navItem.rightBarButtonItem = rightButton
        navItem.leftBarButtonItem = leftButton
        navigationBar.barTintColor = .white
        navigationBar.setItems([navItem], animated: true)
        
        // Edit profile 글씨 크기 조정
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 21),
            .foregroundColor: UIColor.black
        ]
        
        // imagePicker delegate 설정
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        
        navigationBar.titleTextAttributes = titleTextAttributes
        // 화면에 보여지게함
        view.addSubview(navigationBar)
        view.addSubview(imageView)
        view.addSubview(changeButton)
        view.addSubview(nameLabel)
        view.addSubview(firstNameTextField)
        // view.addSubview(lastNameTextField)
        view.addSubview(introduceLabel)
        view.addSubview(introduceTextView)
        
        //
        let safeArea = view.safeAreaLayoutGuide
        
        // 레이아웃
        NSLayoutConstraint.activate([
            // 네비게이션 바
            navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            // 프로필 이미지뷰
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 16.0),
            
            // 프로필 사진 변경 버튼
            changeButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 14.0),
            changeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // name 라벨
            nameLabel.topAnchor.constraint(equalTo: changeButton.bottomAnchor, constant: 15.0),
            nameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 35.0),
            nameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -30.0),
            nameLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            // first name 텍스트 필드
            firstNameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16.0),
            firstNameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30.0),
            firstNameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -30.0),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 50.0),
            
            // introduce 라벨
            introduceLabel.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 25.0),
            introduceLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 35.0),
            introduceLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -30.0),
            introduceLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            // introduce 텍스트 뷰
            introduceTextView.topAnchor.constraint(equalTo: introduceLabel.bottomAnchor, constant: 16.0),
            introduceTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30.0),
            introduceTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -30.0),
            introduceTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -24.0)
            
        ])
    }
    
    @objc func backButtonTap() {
        //
        print("Back")
    }
    
    @objc func doneButtonTap(_sender: Any) {
        showLoadingScreen()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            //
            self.saveData()
            //
            self.dismissLoadingScreen()
        }
        
        print("Save Done")
    }
    
    @objc func changeButtonTap() {
        //
        present(imagePickerController, animated: true, completion: nil)
        
        print("Image change")
    }
    
    //
    func saveData() {
        if let name = firstNameTextField.text {
            UserDefaults.standard.set(name, forKey: "userName")
        }
        if let introduce = introduceTextView.text {
            UserDefaults.standard.set(introduce, forKey: "introduce")
        }
    }
    
    // 로딩화면 만들기
    private var loadingView: UIView?
    
    func showLoadingScreen() {
        // 로딩 화면 뷰 생성
        let loadingView = UIView(frame: view.bounds)
        loadingView.backgroundColor = .white
        loadingView.alpha = 0.5
        
        //
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = loadingView.center
        activityIndicator.startAnimating()
        
        // 뷰에 추가
        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)
        
        self.loadingView = loadingView
    }
    
    func dismissLoadingScreen() {
        guard let loadingView = loadingView else {
            return
        }
        
        loadingView.removeFromSuperview()
        
        self.loadingView = nil
    }

    func initializeUI() {
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
            button.centerYAnchor.constraint(equalTo: layout.centerYAnchor)
        ])
    }

    @objc
    func buttonTapped() {
        print("화면 전환 테스트 코드가 필요하다면 여기 작성하세요.")
        print("Commit하지 않도록 주의하세요.")
    }
}

//
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        var selectedImage: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        // 선택한 이미지 프로필에 설정
        if let image = selectedImage {
            imageView.image = image
        }
        
        // 이미지 선택 창 닫기
        picker.dismiss(animated: true, completion: nil)
    }
}
