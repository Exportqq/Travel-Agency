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
            card.widthAnchor.constraint(equalToConstant: 126),
            card.heightAnchor.constraint(equalToConstant: 177)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(image: UIImage?, name: String) {
        card.configure(image: image, name: name)
    }
}
