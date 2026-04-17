import UIKit

final class IconBubbleView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .searchClr
        view.layer.cornerRadius = 21
        return view
    }()
    
    private let iconView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.tintColor = .black
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(icon: String) {
        iconView.image = UIImage(named: icon)?.withRenderingMode(.alwaysTemplate)
    }
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(iconView)
    }
    
    private func setupConstraints() {
        [containerView, iconView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 42),
            containerView.heightAnchor.constraint(equalToConstant: 42),
            
            iconView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
