import UIKit

final class ProfileViewController: UIViewController {
    private let scrollView = UIScrollView() // scrollView instance
    private let stackView = UIStackView() // stackView instance

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

        scrollView.translatesAutoresizingMaskIntoConstraints = false // autoLayout

        stackView.translatesAutoresizingMaskIntoConstraints = false // autoLayout
        stackView.axis = .vertical

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
        view.addSubview(scrollView) // 뷰에 서브뷰로 추가
        scrollView.addSubview(stackView) // stackView에 서브뷰 추가
        stackView.addSubview(profileView)
        stackView.addSubview(editProfileButton)
        stackView.addSubview(userCreatedLabel)
        stackView.addSubview(tableView)

        NSLayoutConstraint.activate([
            // 스크롤뷰
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            // 스텍뷰
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // 빼먹지 않기

            // 프로필뷰
            profileView.topAnchor.constraint(equalTo: stackView.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 220),

            // edit버튼
            editProfileButton.topAnchor.constraint(equalToSystemSpacingBelow: profileView.bottomAnchor, multiplier: 3),
            editProfileButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            editProfileButton.widthAnchor.constraint(equalTo: editProfileButton.titleLabel!.widthAnchor, constant: 16),

            // Created레이블
            userCreatedLabel.topAnchor.constraint(equalToSystemSpacingBelow: editProfileButton.bottomAnchor, multiplier: 5),
            userCreatedLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            userCreatedLabel.widthAnchor.constraint(equalToConstant: 100),

            // 테이블뷰
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: userCreatedLabel.bottomAnchor, multiplier: 1),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: stackView.leadingAnchor, multiplier: -3),
            tableView.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 3),
            tableView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 2500) // 테이블뷰에 높이를 줬더니 됐다!
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
        return 260
//        return tableView.frame.width
    }
}
