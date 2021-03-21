import UIKit

class ContainerView: UIView {
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        imageView.toAutoLayout()
        return imageView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        let rectangle = CGRect(x: 0, y: 0, width: 10, height: 30)
        let paddingView = UIView(frame: rectangle)
        
        textField.toAutoLayout()
        textField.placeholder = "Email or phone"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.backgroundColor = .systemGray6
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        let rectangle = CGRect(x: 0, y: 0, width: 10, height: 30)
        let paddingView = UIView(frame: rectangle)
        
        textField.toAutoLayout()
        textField.placeholder = "Password"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.backgroundColor = .systemGray6
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        let backgroundImage = #imageLiteral(resourceName: "blue_pixel")
        
        button.toAutoLayout()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.setBackgroundImage(backgroundImage, for: .normal)
        button.setBackgroundImage(backgroundImage.alpha(0.8), for: .selected)
        button.setBackgroundImage(backgroundImage.alpha(0.8), for: .highlighted)
        button.setBackgroundImage(backgroundImage.alpha(0.8), for: .disabled)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        toAutoLayout()
        addSubviews(<#T##subviews: UIView...##UIView#>)
    }

}
