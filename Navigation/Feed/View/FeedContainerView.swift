import UIKit

class FeedContainerView: UIView {
    var onTap: (() -> Void)?
    
    private lazy var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.setTitle("Open post", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func postButtonTapped() {
        guard let onTap = onTap else { return }
        onTap()
    }
    
    private func setupView() {
        addSubview(postButton)
    }
    
    private func setupLayout() {
        let constraints = [
            postButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            postButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
