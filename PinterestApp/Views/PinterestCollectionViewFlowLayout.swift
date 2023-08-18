import UIKit

@objc protocol PinterestCollectionViewDelegateFlowLayout: AnyObject {
    @objc optional func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, contentHeightAt indexPath: IndexPath) -> CGFloat
    @objc optional func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, contentPaddingForSectionAt section: Int) -> CGFloat
}

final class PinterestCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var numberOfColumns = 1
    var contentPadding: CGFloat = 0
    var headerHeight: CGFloat = 0

    weak var delegate: PinterestCollectionViewDelegateFlowLayout?

    private var attributesCache: [UICollectionViewLayoutAttributes] = []
    private var columnHeights: [CGFloat] = []

    override var collectionViewContentSize: CGSize {
        guard let collectionView else { return .zero }
        return .init(
            width: collectionView.bounds.width,
            height: (columnHeights.max() ?? 0) + headerHeight * 2)
    }

    override func prepare() {
        super.prepare()
        guard let collectionView else { return }

        attributesCache = []
        columnHeights = .init(repeating: 0, count: numberOfColumns)

        for section in 0..<collectionView.numberOfSections {
            let contentPadding = delegate?.collectionView?(collectionView, layout: self, contentPaddingForSectionAt: section) ?? contentPadding
            let contentWidth = (collectionView.bounds.width - (CGFloat(numberOfColumns + 1) * contentPadding)) / CGFloat(numberOfColumns)
            let columnOffsets: [CGFloat] = (0..<numberOfColumns).map { CGFloat($0) * (contentWidth + contentPadding) + contentPadding }

            var column = 0
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let contentHeight = contentPadding * 2 + (delegate?.collectionView?(collectionView, layout: self, contentHeightAt: indexPath) ?? contentWidth)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: columnOffsets[column], y: columnHeights[column] + headerHeight + contentPadding, width: contentWidth, height: contentHeight)
                attributesCache.append(attributes)

                columnHeights[column] = columnHeights[column] + contentHeight + contentPadding
                column = (column + 1) % numberOfColumns
            }
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = attributesCache.filter { $0.frame.intersects(rect) }
        if let headerAttributes = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) {
            attributes.append(headerAttributes)
        }
        return attributes
    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if elementKind == UICollectionView.elementKindSectionHeader {
            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)
            attributes.frame = .init(x: 0, y: 0, width: collectionView?.frame.width ?? 0, height: headerHeight)
            return attributes
        }
        return nil
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        attributesCache[indexPath.item]
    }
}
