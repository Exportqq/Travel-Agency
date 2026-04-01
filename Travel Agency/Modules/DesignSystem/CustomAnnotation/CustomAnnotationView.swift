import UIKit
import MapKit
import Kingfisher

final class CustomAnnotationView: MKAnnotationView {
    
    static let identifier = "CustomAnnotationView"
    
    private let imageView = UIImageView()
 
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Regular_Bold", size: 24)
        lbl.textColor = .white
        return lbl
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        frame = CGRect(x: 0, y: 0, width: 90, height: 110)
        
        imageView.frame = CGRect(x: 15, y: 0, width: 60, height: 60)
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        titleLabel.frame = CGRect(x: 0, y: 65, width: 200, height: 80)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    func configure(with annotation: CustomAnnotation) {
        titleLabel.text = annotation.title

        if let urlString = annotation.imageUrl,
           let url = URL(string: urlString) {
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = UIImage(named: "testt") 
        }
    }
}
