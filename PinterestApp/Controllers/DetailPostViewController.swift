import UIKit

final class DetailPostViewController: UIViewController {
    var medium: Medium? {
        didSet {
            setupContent()
        }
    }

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()

    private lazy var profileStackView: UIStackView = {
        let profileStackView = UIStackView()
        profileStackView.axis = .horizontal
        return profileStackView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var profileView: UIImageView = {
        let profileView = UIImageView()
        profileView.layer.cornerRadius = 50
        profileView.clipsToBounds = true
        return profileView
    }()

    private lazy var nameLabel: UILabel = {
        let username = UILabel()
        return username
    }()

    private lazy var captionLabel: UITextView = {
        let caption = UITextView()
        caption.isEditable = false
        caption.font = .systemFont(ofSize: 16)
        return caption
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupStyle()
        setupLayout()
        setupContent()
    }

    private func setupContent() {
        imageView.image = medium?.image
        profileView.image = medium?.author?.avatar ?? .init(named: "default_profile")
        nameLabel.text = medium?.author?.name ?? "Anonymous User"
        captionLabel.text = "\(medium?.title ?? "Untitled")\n\n\(medium?.caption ?? "Empty")"
    }
}

extension DetailPostViewController {
    private func setupStyle() {
        view.backgroundColor = .systemBackground

        stackView.axis = .vertical
        stackView.distribution = .fill
        profileStackView.axis = .horizontal
        profileStackView.distribution = .fill
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.addSubview(imageView)
        stackView.addSubview(profileStackView)
        stackView.addSubview(captionLabel)

        profileStackView.addSubview(profileView)
        profileStackView.addSubview(nameLabel)

        [scrollView, stackView, imageView, profileStackView, nameLabel, captionLabel].forEach { removeDefaultConstraints(view: $0) }

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),

            imageView.topAnchor.constraint(equalTo: stackView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),

            profileStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            profileStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            profileStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            profileStackView.heightAnchor.constraint(equalToConstant: 100),

            profileView.widthAnchor.constraint(equalToConstant: 100),
            profileView.heightAnchor.constraint(equalToConstant: 100),
            
            captionLabel.topAnchor.constraint(equalTo: profileStackView.bottomAnchor),
            captionLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            captionLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            captionLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),

            nameLabel.leadingAnchor.constraint(equalTo: profileView.trailingAnchor),
            nameLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: captionLabel.topAnchor)
        ])
    }
}
