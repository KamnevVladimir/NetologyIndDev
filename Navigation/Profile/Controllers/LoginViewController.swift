import UIKit

//MARK: - LoginViewControllerDelegate
protocol LoginViewControllerDelegate {
    func checkLogin(controller: LoginViewController, login: String) -> Bool
    func checkPassword(controller: LoginViewController, password: String) -> Bool
}

//MARK: - LoginViewController
final class LoginViewController: UIViewController {
    weak var coordinator: ProfileFlowCoordinator?
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        imageView.toAutoLayout()
        return imageView
    }()
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        let rectangle = CGRect(x: 0, y: 0, width: 10, height: 30)
        let paddingView = UIView(frame: rectangle)
        
        textField.placeholder = "Email or phone"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.backgroundColor = UIColor(red: 242, green: 242, blue: 247)
        textField.autocapitalizationType = .none
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.returnKeyType = .done
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        let rectangle = CGRect(x: 0, y: 0, width: 10, height: 30)
        let paddingView = UIView(frame: rectangle)
        
        textField.placeholder = "Password"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.backgroundColor = UIColor(red: 242, green: 242, blue: 247)
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.returnKeyType = .done
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        let backgroundImage = #imageLiteral(resourceName: "blue_pixel")
        
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
    
    private lazy var scrollView = UIScrollView()
    private lazy var containerView = UIView()
    private lazy var logoImageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        hideKeyboardWhenTappedAround()
        setupViews()
        setupLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        /// Keyboard observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Keyboard actions
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

    
    @objc private func loginButtonPressed() {
        coordinator?.showProfileVC()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(logoImageView, loginButton, loginTextField, passwordTextField)
    }
    
    private func setupLayouts() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { (make) in
            make.edges.width.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(120)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        loginTextField.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).inset(-120)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }

        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(loginTextField.snp.bottom)
            make.leading.trailing.height.equalTo(loginTextField)
        }

        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).inset(-16)
            make.leading.trailing.height.equalTo(loginTextField)
            make.bottom.equalToSuperview().inset(-16)
        }
    }

}
