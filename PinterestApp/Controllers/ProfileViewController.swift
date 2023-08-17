import UIKit

final class ProfileViewController: UIViewController {
    let profileView = ProfileView()
    let editProfileButton = UIButton(type: .system)

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = true
        tableView.register(ProfileCustomCell.self, forCellReuseIdentifier: ProfileCustomCell.identifier)

        return tableView
    }()

    let userCreatedLabel = UILabel()

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
        profileView.translatesAutoresizingMaskIntoConstraints = false

        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.backgroundColor = .systemGray
        editProfileButton.setTitle("Edit", for: .normal)
        editProfileButton.setTitleColor(.darkText, for: .normal)
        editProfileButton.layer.cornerRadius = 5

        editProfileButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        userCreatedLabel.translatesAutoresizingMaskIntoConstraints = false
        userCreatedLabel.textAlignment = .center
        userCreatedLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        userCreatedLabel.adjustsFontForContentSizeCategory = true
        userCreatedLabel.text = "Created"

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileCustomCell.self, forCellReuseIdentifier: ProfileCustomCell.identifier)
    }

    private func setupLayout() {
        view.addSubview(profileView)
        view.addSubview(editProfileButton)
        view.addSubview(userCreatedLabel)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            profileView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            profileView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: -3),

            profileView.heightAnchor.constraint(equalToConstant: 255),

            editProfileButton.topAnchor.constraint(equalToSystemSpacingBelow: profileView.bottomAnchor, multiplier: 3),
            editProfileButton.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),

            editProfileButton.widthAnchor.constraint(equalTo: editProfileButton.titleLabel!.widthAnchor, constant: 16),

            userCreatedLabel.topAnchor.constraint(equalToSystemSpacingBelow: editProfileButton.bottomAnchor, multiplier: 5),
            userCreatedLabel.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),
            userCreatedLabel.widthAnchor.constraint(equalToConstant: 100),

            tableView.topAnchor.constraint(equalToSystemSpacingBelow: userCreatedLabel.bottomAnchor, multiplier: 1),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: -3),
            tableView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 3),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ProfileViewController {
    @objc
    private func buttonTapped() {
        navigationController?.pushViewController(EditProfileViewController(), animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate {}

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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width
    }
}
