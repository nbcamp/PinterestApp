import UIKit

final class HomeViewController: UIViewController {
    var collectionView: UICollectionView!
    let columns = 2

    private var media: [Medium] { MediumService.shared.media }

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
        
        MediumService.shared.load { [weak self] _ in
            self?.collectionView.reloadData()
        }
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

extension HomeViewController: PinterestCollectionViewDelegateFlowLayout {
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
