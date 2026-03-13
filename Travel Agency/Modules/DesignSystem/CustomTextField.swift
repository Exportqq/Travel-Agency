import UIKit

final class CustomTextField: UITextField {

    var padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        layer.borderWidth = 0
        layer.cornerRadius = 10
        backgroundColor = .fieldBackground
        textColor = .textBlack
        font = UIFont(name: "Poppins-Medium", size: 16)
        
    }

    func configure(placeholder: String) {
        self.placeholder = placeholder
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

}
