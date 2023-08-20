import UIKit

final class ProfileViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    private var authUser = AuthService.shared.user {
        didSet {
            userImage.image = authUser?.avatar ?? UIImage(named: "default_profile")
            userNameLabel.text = authUser?.name
            userDetail.text = authUser?.introduce
        }
    }

    private let userImage = UIImageView()
    private let userNameLabel = UILabel()
    private let userDetail = UILabel()

    private let editProfileButton = UIButton(type: .system)

    private let subStackView = UIStackView()
    private let userCreatedLabel = UILabel()
    private let gridButton = UIButton(type: .system)
    private let plusButton = UIButton(type: .system)

    private var collectionView: UICollectionView!

    var columns = 2

    private var media: [Medium] { MediumService.shared.media }

    private var currentGridType: GridType = .square2x2

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupLayout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension ProfileViewController {
    private func setupStyle() {
        view.backgroundColor = .systemBackground

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.image = authUser?.avatar ?? UIImage(named: "default_profile")
        userImage.backgroundColor = .systemGray
        userImage.contentMode = .scaleAspectFill
        userImage.clipsToBounds = true
        userImage.layer.borderWidth = 2.0
        userImage.layer.borderColor = UIColor.white.cgColor
        userImage.layer.cornerRadius = 75
        userImage.layer.shadowOffset = CGSize(width: 5, height: 5)
        userImage.layer.shadowOpacity = 0.7
        userImage.layer.shadowRadius = 5
        userImage.layer.shadowColor = UIColor.gray.cgColor

        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.textAlignment = .center
        userNameLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle).withSize(48)
        userNameLabel.adjustsFontForContentSizeCategory = true
        userNameLabel.text = authUser?.name

        userDetail.translatesAutoresizingMaskIntoConstraints = false
        userDetail.textAlignment = .center
        userDetail.font = UIFont.preferredFont(forTextStyle: .caption2).withSize(16)
        userDetail.adjustsFontForContentSizeCategory = true
        userDetail.numberOfLines = 0
        userDetail.text = authUser?.introduce

        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.backgroundColor = .white
        editProfileButton.setTitle("변경", for: .normal)
        editProfileButton.setTitleColor(.darkText, for: .normal)
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.layer.borderWidth = 1.0
        editProfileButton.layer.borderColor = UIColor.systemGray.cgColor
        editProfileButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)

        subStackView.translatesAutoresizingMaskIntoConstraints = false
        subStackView.axis = .horizontal

        userCreatedLabel.translatesAutoresizingMaskIntoConstraints = false
        userCreatedLabel.textAlignment = .center
        userCreatedLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        userCreatedLabel.adjustsFontForContentSizeCategory = true
        userCreatedLabel.text = "My Posting"

        gridButton.translatesAutoresizingMaskIntoConstraints = false
        gridButton.setImage(UIImage(systemName: "square.grid.2x2.fill"), for: .normal)
        gridButton.tintColor = .label
        gridButton.addTarget(self, action: #selector(gridButtonTapped), for: .touchUpInside)

        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = .label
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)

        let layout = PinterestCollectionViewFlowLayout()
        layout.numberOfColumns = columns
        layout.delegate = self
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            ImageCollectionViewCell.self,
            forCellWithReuseIdentifier: ImageCollectionViewCell.identifier
        )
    }

    private func setupLayout() {
        view.addSubview(scrollView)

        scrollView.addSubview(stackView)

        stackView.addSubview(userImage)
        stackView.addSubview(userNameLabel)
        stackView.addSubview(userDetail)
        stackView.addSubview(editProfileButton)
        stackView.addSubview(subStackView)
        subStackView.addSubview(userCreatedLabel)
        subStackView.addSubview(gridButton)
        subStackView.addSubview(plusButton)
        stackView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            userImage.topAnchor.constraint(equalToSystemSpacingBelow: stackView.topAnchor, multiplier: 3),
            userImage.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            userImage.widthAnchor.constraint(equalToConstant: 150),
            userImage.heightAnchor.constraint(equalToConstant: 150),

            userNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: userImage.bottomAnchor, multiplier: 1.5),
            userNameLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),

            userDetail.topAnchor.constraint(equalToSystemSpacingBelow: userNameLabel.bottomAnchor, multiplier: 1.5),
            userDetail.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            userDetail.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.6),

            editProfileButton.topAnchor.constraint(equalToSystemSpacingBelow: userDetail.bottomAnchor, multiplier: 1.5),
            editProfileButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            editProfileButton.widthAnchor.constraint(equalTo: editProfileButton.titleLabel!.widthAnchor, constant: 16),

            subStackView.topAnchor.constraint(equalToSystemSpacingBelow: editProfileButton.bottomAnchor, multiplier: 3),
            subStackView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            subStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            subStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            subStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor),

            userCreatedLabel.topAnchor.constraint(equalTo: subStackView.topAnchor),
            userCreatedLabel.centerXAnchor.constraint(equalTo: subStackView.centerXAnchor),
            userCreatedLabel.widthAnchor.constraint(equalToConstant: 100),

            gridButton.topAnchor.constraint(equalTo: subStackView.topAnchor),
            gridButton.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -1),
            gridButton.heightAnchor.constraint(equalTo: userCreatedLabel.heightAnchor),
            gridButton.widthAnchor.constraint(equalTo: gridButton.heightAnchor),

            plusButton.topAnchor.constraint(equalTo: subStackView.topAnchor),
            plusButton.trailingAnchor.constraint(equalTo: subStackView.trailingAnchor, constant: -22),
            plusButton.heightAnchor.constraint(equalTo: userCreatedLabel.heightAnchor),
            plusButton.widthAnchor.constraint(equalTo: plusButton.heightAnchor),

            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: plusButton.bottomAnchor, multiplier: 1),
            collectionView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 3),
        ])
    }
}

extension ProfileViewController: UICollectionViewDelegate {}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return media.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }

        let medium = media[indexPath.item]
        cell.imageView.image = medium.image
        return cell
    }
}

extension ProfileViewController: PinterestCollectionViewDelegateFlowLayout {
    var contentPadding: CGFloat { 10.0 }

    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, contentHeightAt indexPath: IndexPath) -> CGFloat {
        let image = media[indexPath.item]
        let width = (collectionView.bounds.width - (CGFloat(columns + 1) * contentPadding)) / CGFloat(columns)
        return width * (Double(image.height) / Double(image.width))
    }

    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, contentPaddingForSectionAt section: Int) -> CGFloat {
        return contentPadding
    }
}

extension ProfileViewController {
    @objc
    private func editButtonTapped() {
        let editProfileVC = EditProfileViewController()
        editProfileVC.authUser = authUser
        editProfileVC.delegate = self
        navigationController?.pushViewController(editProfileVC, animated: true)
    }

    private enum GridType {
        case square3x3, square1x1, square2x2
    }

    @objc
    private func gridButtonTapped() {
        switch currentGridType {
            case .square3x3:
                currentGridType = .square1x1
                gridButton.setImage(UIImage(systemName: "square.fill"), for: .normal)
                columns = 1
            case .square1x1:
                currentGridType = .square2x2
                gridButton.setImage(UIImage(systemName: "square.grid.2x2.fill"), for: .normal)
                columns = 2
            case .square2x2:
                currentGridType = .square3x3
                gridButton.setImage(UIImage(systemName: "square.grid.3x3.fill"), for: .normal)
                columns = 3
        }

        updateCollectionViewLayout()
    }

    private func updateCollectionViewLayout() {
        let layout = collectionView.collectionViewLayout as! PinterestCollectionViewFlowLayout
        layout.numberOfColumns = columns
        layout.invalidateLayout()

        collectionView.reloadData()
    }

    @objc
    private func plusButtonTapped() {
        navigationController?.pushViewController(NewPostViewController(), animated: true)
    }
}

extension ProfileViewController: EditProfileViewControllerDelegate {
    func userProfileDidEdit(user: User) {
        authUser = user
    }
}
