import UIKit

final class ProfileViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    let profileView = ProfileView()
    let editProfileButton = UIButton(type: .system)

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

        profileView.translatesAutoresizingMaskIntoConstraints = false

        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.backgroundColor = .systemGray
        editProfileButton.setTitle("Edit", for: .normal)
        editProfileButton.setTitleColor(.darkText, for: .normal)
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)

        subStackView.translatesAutoresizingMaskIntoConstraints = false
        subStackView.axis = .horizontal

        userCreatedLabel.translatesAutoresizingMaskIntoConstraints = false
        userCreatedLabel.textAlignment = .center
        userCreatedLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        userCreatedLabel.adjustsFontForContentSizeCategory = true
        userCreatedLabel.text = "Created"

        gridButton.translatesAutoresizingMaskIntoConstraints = false
        gridButton.setImage(UIImage(systemName: "square.grid.2x2.fill"), for: .normal)
        gridButton.tintColor = .darkText
        gridButton.addTarget(self, action: #selector(gridButtonTapped), for: .touchUpInside)

        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = .darkText
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

        stackView.addSubview(profileView)
        stackView.addSubview(editProfileButton)
        stackView.addSubview(subStackView)

        subStackView.addSubview(userCreatedLabel)
        subStackView.addSubview(gridButton)
        subStackView.addSubview(plusButton)
        subStackView.addSubview(collectionView)

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

            profileView.topAnchor.constraint(equalTo: stackView.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 220),

            editProfileButton.topAnchor.constraint(equalToSystemSpacingBelow: profileView.bottomAnchor, multiplier: 3),
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

            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: userCreatedLabel.bottomAnchor, multiplier: 1),
            collectionView.leadingAnchor.constraint(equalTo: subStackView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: subStackView.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: subStackView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 2000),
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
        navigationController?.pushViewController(EditProfileViewController(), animated: true)
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

        updateCollectionViewLayout() // 리로드 안 됨
    }

    //
    private func updateCollectionViewLayout() {
        let layout = collectionView.collectionViewLayout as! PinterestCollectionViewFlowLayout
        layout.numberOfColumns = columns
        layout.invalidateLayout()

        collectionView.reloadData()
        print("CollectionView columns: \(columns)")
    }

    @objc
    private func plusButtonTapped() {
        navigationController?.pushViewController(NewPostViewController(), animated: true)
    }
}
