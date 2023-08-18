import UIKit

@objc protocol PinterestCollectionViewDelegateFlowLayout: AnyObject {
    @objc optional func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, contentHeightAt indexPath: IndexPath) -> CGFloat
    @objc optional func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, contentPaddingForSectionAt section: Int) -> CGFloat
}

final class PinterestCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var numberOfColumns = 1
    var contentPadding: CGFloat = 0

    weak var delegate: PinterestCollectionViewDelegateFlowLayout?

    private var attributesCache: [UICollectionViewLayoutAttributes] = []
    private var columnHeights: [CGFloat] = []

    override var collectionViewContentSize: CGSize {
        guard let collectionView else { return .zero }
        return .init(width: collectionView.bounds.width, height: columnHeights.max() ?? 0)
    }

    override func prepare() {
        super.prepare()
        guard let collectionView, attributesCache.isEmpty else { return }

        columnHeights = .init(repeating: 0, count: numberOfColumns)
        attributesCache = []

        for section in 0..<collectionView.numberOfSections {
            let contentPadding = delegate?.collectionView?(collectionView, layout: self, contentPaddingForSectionAt: section) ?? contentPadding
            let contentWidth = (collectionView.bounds.width - (CGFloat(numberOfColumns + 1) * contentPadding)) / CGFloat(numberOfColumns)
            let columnOffsets: [CGFloat] = (0..<numberOfColumns).map { CGFloat($0) * (contentWidth + contentPadding) + contentPadding }

            var column = 0
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let contentHeight = contentPadding * 2 + (delegate?.collectionView?(collectionView, layout: self, contentHeightAt: indexPath) ?? contentWidth)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: columnOffsets[column], y: columnHeights[column], width: contentWidth, height: contentHeight)
                attributesCache.append(attributes)

                columnHeights[column] = columnHeights[column] + contentHeight + contentPadding
                column = (column + 1) % numberOfColumns
            }
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        attributesCache.filter { $0.frame.intersects(rect) }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        attributesCache[indexPath.item]
    }
}
