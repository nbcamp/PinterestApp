import UIKit

class ProfileCustomCell: UITableViewCell {
    static let identifier = "CustomCell"
    private let myImageView = UIImageView(image: UIImage(systemName: "questionmark"))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileCustomCell {
    public func configure(with image: UIImage) {
        myImageView.image = image
    }

    private func setupUI() {
        contentView.addSubview(myImageView)

        myImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            myImageView.heightAnchor.constraint(equalTo: myImageView.widthAnchor),

        ])
    }
}
