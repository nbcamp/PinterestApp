import UIKit

final class HomeViewController: UIViewController {
    private lazy var flowLayout = {
        let layout = PinterestCollectionViewFlowLayout()
        layout.numberOfColumns = 2
        layout.headerHeight = 50.0
        layout.delegate = self
        return layout
    }()

    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            ImageCollectionViewCell.self,
            forCellWithReuseIdentifier: ImageCollectionViewCell.identifier
        )
        collectionView.register(
            SearchBarCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SearchBarCollectionReusableView.identifier
        )
        return collectionView
    }()

    private let columns = 2
    private var media: [Medium] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
        setupTapGesture()
        loadData()
    }

    private func initializeUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)

        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }

    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    private func loadData() {
        let progressView = UIProgressView()
        MediumService.shared.load { progress in
            progressView.setProgress(Float(progress), animated: true)
        } completion: { [weak self] media in
            progressView.removeFromSuperview()
            self?.media = media ?? []
            self?.collectionView.reloadData()
        }

        view.addSubview(progressView)
        let safeArea = view.safeAreaLayoutGuide
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50),
            progressView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50),
            progressView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 10),
        ])
    }

    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
}

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

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SearchBarCollectionReusableView.identifier,
                for: indexPath
            ) as? SearchBarCollectionReusableView {
                header.onSearch = { [weak self] text in
                    MediumService.shared.search(query: text) { media in
                        self?.media = media ?? []
                        self?.collectionView.reloadData()
                    }
                }
                return header
            }
        }
        return UICollectionReusableView()
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
