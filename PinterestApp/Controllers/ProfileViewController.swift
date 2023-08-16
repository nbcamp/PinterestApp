import UIKit

final class ProfileViewController: UIViewController {
    let profileView = ProfileView()
    let EditProfileButton = UIButton(type: .system)

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = true
        tableView.register(ProfileCustomCell.self, forCellReuseIdentifier: ProfileCustomCell.identifier)

        return tableView
    }()

    let usereCreatedLabel = UILabel()

    private let images: [UIImage] = [
        UIImage(named: "1")!,
        UIImage(named: "2")!,
        UIImage(named: "3")!,
        UIImage(named: "4")!,
        UIImage(named: "5")!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        layout()

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension ProfileViewController {
    private func style() {
        view.backgroundColor = .systemBackground
        profileView.translatesAutoresizingMaskIntoConstraints = false

        EditProfileButton.translatesAutoresizingMaskIntoConstraints = false
        EditProfileButton.backgroundColor = .systemGray
        EditProfileButton.setTitle("Edit", for: .normal)
        EditProfileButton.setTitleColor(.darkText, for: .normal)
        EditProfileButton.layer.cornerRadius = 5

        EditProfileButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        usereCreatedLabel.translatesAutoresizingMaskIntoConstraints = false
        usereCreatedLabel.textAlignment = .center
        usereCreatedLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        usereCreatedLabel.adjustsFontForContentSizeCategory = true
        usereCreatedLabel.text = "Created"

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileCustomCell.self, forCellReuseIdentifier: "CustomCell")
    }

    private func layout() {
        view.addSubview(profileView)
        view.addSubview(EditProfileButton)
        view.addSubview(usereCreatedLabel)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            profileView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            profileView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: -3),

            profileView.heightAnchor.constraint(equalToConstant: 255),

            EditProfileButton.topAnchor.constraint(equalToSystemSpacingBelow: profileView.bottomAnchor, multiplier: 3),
            EditProfileButton.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),

            EditProfileButton.widthAnchor.constraint(equalTo: EditProfileButton.titleLabel!.widthAnchor, constant: 16),

            usereCreatedLabel.topAnchor.constraint(equalToSystemSpacingBelow: EditProfileButton.bottomAnchor, multiplier: 5),
            usereCreatedLabel.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),
            usereCreatedLabel.widthAnchor.constraint(equalToConstant: 100),

            tableView.topAnchor.constraint(equalToSystemSpacingBelow: usereCreatedLabel.bottomAnchor, multiplier: 1),
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

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
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
