//
//  ProfileView.swift
//  PinterestApp
//
//  Created by SR on 2023/08/16.
//

import UIKit

class ProfileView: UIView {
    let stackView = UIStackView()
    let userImage = UIImageView(image: UIImage(named: "01"))
    let userNameLabel = UILabel()
    let userDetail = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8

        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.backgroundColor = .white
        userImage.contentMode = .scaleAspectFill
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = 75 // 반지름은 너비 또는 높이의 절반이어야 원형 구현
        userImage.layer.shadowOffset = CGSize(width: 5, height: 5)
        userImage.layer.shadowOpacity = 0.7
        userImage.layer.shadowRadius = 5
        userImage.layer.shadowColor = UIColor.gray.cgColor

        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.textAlignment = .center
        userNameLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        userNameLabel.adjustsFontForContentSizeCategory = true
        userNameLabel.text = "User"

        userDetail.translatesAutoresizingMaskIntoConstraints = false
        userDetail.textAlignment = .center
        userDetail.font = UIFont.preferredFont(forTextStyle: .title3)
        userDetail.adjustsFontForContentSizeCategory = true
        userDetail.numberOfLines = 0
        userDetail.text = "@user 🌿 Welcome!!"
    }

    func layout() {
        stackView.addArrangedSubview(userImage)
        stackView.addArrangedSubview(userNameLabel)
        stackView.addArrangedSubview(userDetail)

        addSubview(stackView)

        stackView.alignment = .center

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
        ])

        NSLayoutConstraint.activate([
            userImage.widthAnchor.constraint(equalToConstant: 150),
            userImage.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
}

