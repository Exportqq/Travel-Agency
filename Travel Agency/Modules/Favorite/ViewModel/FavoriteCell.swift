import UIKit

final class FavoriteCell: UICollectionViewCell {
    
    let card = FavoriteCardView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: contentView.topAnchor),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            card.heightAnchor.constraint(equalToConstant: 132)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
