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
    
    // 콜렉션뷰로 변경 예정...
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = true
        tableView.register(ProfileCustomCell.self, forCellReuseIdentifier: ProfileCustomCell.identifier)

        return tableView
    }()

    private let images: [UIImage] = [
        UIImage(named: "1")!,
        UIImage(named: "2")!,
        UIImage(named: "3")!,
        UIImage(named: "4")!,
        UIImage(named: "5")!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStyle()
        setupLayout()

        tableView.dataSource = self
        tableView.delegate = self
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
        stackView.axis = .horizontal

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

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileCustomCell.self, forCellReuseIdentifier: ProfileCustomCell.identifier)
    }

    private func setupLayout() {
        view.addSubview(scrollView)

        scrollView.addSubview(stackView)

        stackView.addSubview(profileView)
        stackView.addSubview(editProfileButton)
        stackView.addSubview(subStackView)
        stackView.addSubview(tableView)

        subStackView.addSubview(userCreatedLabel)
        subStackView.addSubview(gridButton)
        subStackView.addSubview(plusButton)

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

            tableView.topAnchor.constraint(equalToSystemSpacingBelow: userCreatedLabel.bottomAnchor, multiplier: 1),
            tableView.leadingAnchor.constraint(equalTo: subStackView.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: subStackView.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: subStackView.bottomAnchor),
            tableView.heightAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: CGFloat(images.count))
        ])
    }
}

extension ProfileViewController {
    @objc
    private func editButtonTapped() {
        navigationController?.pushViewController(EditProfileViewController(), animated: true)
    }

    @objc
    private func gridButtonTapped() {
        print("girdButton Tapped!")
    }

    @objc
    private func plusButtonTapped() {
        navigationController?.pushViewController(NewPostViewController(), animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellSpacing: CGFloat = 5
        let screenWidth = tableView.bounds.width
        let cellHeight = screenWidth * 0.9
        return cellHeight + cellSpacing
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCustomCell.identifier, for: indexPath) as? ProfileCustomCell else {
            fatalError("The TableView could not dequeue a CustomCell in ViewController.")
        }

        let image = images[indexPath.row]
        cell.configure(with: image)

        return cell
    }
}
