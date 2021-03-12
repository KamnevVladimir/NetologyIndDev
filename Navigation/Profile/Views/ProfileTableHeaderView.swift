import UIKit

final class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "cat.jpg"))
        
        image.toAutoLayout()
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 3
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        return image
    }()
    
    private lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Coocie-Cat Om"
        
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 0x54, green: 0x54, blue: 0x54)
        label.text = "Waiting for something to eat..."
        
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        
        textField.toAutoLayout()
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
        
        return textField
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.toAutoLayout()
        button.backgroundColor = UIColor(red: 0x46, green: 0x82, blue: 0xB4)
        button.setTitle("Show status", for: .normal)
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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func setupViews() {
        contentView.backgroundColor = .systemGray6
        
        contentView.addSubviews(profileImageView,
                    profileNameLabel,
                    statusLabel,
                    statusTextField,
                    statusButton)
        
        let constraints = [
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            profileNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            profileNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            statusLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -18),
            statusLabel.leadingAnchor.constraint(equalTo: profileNameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: profileNameLabel.trailingAnchor),
            
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            statusTextField.leadingAnchor.constraint(equalTo: profileNameLabel.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: profileNameLabel.trailingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            statusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            statusButton.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            statusButton.trailingAnchor.constraint(equalTo: profileNameLabel.trailingAnchor),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        profileImageView.makeRound()
    }
    
    @objc private func statusButtonPressed() {
        statusLabel.text = statusText
        print(statusLabel.text ?? "")
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
}


