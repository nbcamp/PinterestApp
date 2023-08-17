import UIKit

struct Image {
    let url: String
    let width: Int
    let height: Int
}

final class HomeViewController: UIViewController {
    var collectionView: UICollectionView!
    let columns = 2

    let images: [Image] = (0 ..< 100).map { _ in
        let width = 200
        let height = Int.random(in: 1 ... 3) * 100

        return Image(
            url: "https://picsum.photos/\(width)/\(height)",
            width: width,
            height: height
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
    }

    private func initializeUI() {
        view.backgroundColor = .systemBackground

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

        view.addSubview(collectionView)

        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }

    @objc
    private func buttonTapped() {
        navigationController?.pushViewController(DetailPostViewController(), animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate {}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }

        let image = images[indexPath.item]
        cell.imageView.load(url: URL(string: image.url)!)
        return cell
    }
}

extension HomeViewController: PinterestCollectionViewDelegateFlowLayout {
    var contentPadding: CGFloat { 10.0 }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, contentHeightAt indexPath: IndexPath) -> CGFloat {
        let image = images[indexPath.item]
        let width = (collectionView.bounds.width - (CGFloat(columns + 1) * contentPadding)) / CGFloat(columns)
        return width * (Double(image.height) / Double(image.width))
    }

    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, contentPaddingForSectionAt section: Int) -> CGFloat {
        return contentPadding
    }
}
