//
//  ProfileViewController.swift
//  PinterestApp
//
//  Created by SR on 2023/08/16.
//

import UIKit

class ProfileViewController: UIViewController {
    let profileView = ProfileView()
    let EditProfileButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        layout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension ProfileViewController {
    private func style() {
        profileView.translatesAutoresizingMaskIntoConstraints = false

        EditProfileButton.translatesAutoresizingMaskIntoConstraints = false
        EditProfileButton.backgroundColor = .systemGray
        EditProfileButton.setTitle("Edit", for: [])
        EditProfileButton.setTitleColor(.darkText, for: .normal)
        EditProfileButton.layer.cornerRadius = 10

        EditProfileButton.addTarget(self, action: #selector(EditProfileTapped), for: .primaryActionTriggered)
    }

    private func layout() {
        view.addSubview(profileView)
        view.addSubview(EditProfileButton)

        NSLayoutConstraint.activate([
            profileView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            profileView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: profileView.trailingAnchor, multiplier: 1),
        ])

        NSLayoutConstraint.activate([
            EditProfileButton.topAnchor.constraint(equalToSystemSpacingBelow: profileView.bottomAnchor, multiplier: 2),
            EditProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
    }
}

extension ProfileViewController {
    @objc func EditProfileTapped() {
        print("Edit Button Tapped")
    }
}
