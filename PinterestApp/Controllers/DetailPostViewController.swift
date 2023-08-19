import UIKit

final class DetailPostViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .green
        return scrollView
    }()
        
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .red
        return stackView
    }()

    private let profileStackView: UIStackView = {
        let profileStackView = UIStackView()
        profileStackView.backgroundColor = .purple
        return profileStackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let profileView: UIImageView = {
        let profileView = UIImageView()
        profileView.backgroundColor = .blue
        profileView.layer.cornerRadius = 50
        profileView.clipsToBounds = true
        return profileView
    }()
        
    let label1: UILabel = {
        let username = UILabel()
        username.backgroundColor = .yellow
        username.text = "name"
        username.translatesAutoresizingMaskIntoConstraints = false
        return username
    }()
        
    let label2: UILabel = {
        let caption = UILabel()
        caption.backgroundColor = .lightGray
        caption.text = "user's text"
        caption.translatesAutoresizingMaskIntoConstraints = false
        return caption
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupStyle()
        setupLayout()
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension DetailPostViewController {
    private func setupStyle() {
        view.backgroundColor = .systemBackground
                
        scrollView.translatesAutoresizingMaskIntoConstraints = false
                
        imageView.translatesAutoresizingMaskIntoConstraints = false
                    
        profileView.translatesAutoresizingMaskIntoConstraints = false
                
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
            
        profileStackView.translatesAutoresizingMaskIntoConstraints = false
        profileStackView.axis = .horizontal
        profileStackView.distribution = .fill
    }
            
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
            
        stackView.addSubview(imageView)
        stackView.addSubview(profileStackView)
        stackView.addSubview(label2)
            
        profileStackView.addSubview(profileView)
        profileStackView.addSubview(label1)
                
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            imageView.topAnchor.constraint(equalTo: stackView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 370),
            label2.topAnchor.constraint(equalTo: profileStackView.bottomAnchor),
            label2.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            label2.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            profileStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            profileStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            profileStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            profileStackView.heightAnchor.constraint(equalToConstant: 100),
            profileView.widthAnchor.constraint(equalToConstant: 100),
            profileView.heightAnchor.constraint(equalToConstant: 100),
            label1.leadingAnchor.constraint(equalTo: profileView.trailingAnchor),
            label1.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            label1.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            label1.bottomAnchor.constraint(equalTo: label2.topAnchor)
        ])
    }
}

// map 대신 for
