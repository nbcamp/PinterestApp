import UIKit

class ProfileCustomCell: UITableViewCell {
    static let identifier = "CustomCell"
    private var myImageView = UIImageView(image: UIImage(systemName: "questionmark"))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        myImageView = UIImageView()
        myImageView.contentMode = .scaleAspectFill
        myImageView.clipsToBounds = true
        myImageView.layer.cornerRadius = 5.0
        myImageView.layer.masksToBounds = true
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
            myImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            myImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            myImageView.widthAnchor.constraint(equalToConstant: 310),
            myImageView.heightAnchor.constraint(equalToConstant: 310)
        ])
    }
}
