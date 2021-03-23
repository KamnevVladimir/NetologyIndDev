import UIKit

final class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "cat.jpg"))
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 3
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Coocie-Cat Om"
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 0x54, green: 0x54, blue: 0x54)
        label.text = "Waiting for something to eat..."
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        textField.returnKeyType = .done
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.placeholder = "Set your status"
        
        return textField
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = UIColor(red: 0x46, green: 0x82, blue: 0xB4)
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.setShadowWithColor(opacity: 0.7, offset: CGSize(width: 4, height: 4), radius: 4)
        
        button.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var statusText: String = ""
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func setupViews() {
        contentView.backgroundColor = UIColor(red: 242, green: 242, blue: 247)
        
        contentView.addSubviews(profileImageView,
                    profileNameLabel,
                    statusLabel,
                    statusTextField,
                    statusButton)
    }
    
    private func setupLayouts() {
        profileImageView.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(16)
            make.size.equalTo(100)
        }
        profileImageView.makeRound()
        
        profileNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(27)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(profileImageView.snp.trailing).inset(-16)
        }
        
        statusLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(profileNameLabel)
            make.top.equalTo(profileImageView.snp.bottom).inset(18)
        }
        
        statusTextField.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(profileNameLabel)
            make.top.equalTo(statusLabel.snp.bottom).inset(-16)
            make.height.equalTo(40)
        }
        
        statusButton.snp.makeConstraints { (make) in
            make.top.equalTo(statusTextField.snp.bottom).inset(-16)
            make.leading.equalTo(profileImageView)
            make.trailing.equalTo(profileNameLabel)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    @objc private func statusButtonPressed() {
        statusLabel.text = statusText
        print(statusLabel.text ?? "")
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
}


