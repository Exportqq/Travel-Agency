import UIKit

final class LocationCell: UICollectionViewCell {
    
    private let card = LocationCardView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: contentView.topAnchor),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(image: UIImage?, name: String) {
        card.configure(image: image, name: name)
    }
}
