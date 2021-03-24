import UIKit

final class ProfileStackTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Photos"
        return label
    }()
    
    private lazy var detailedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.image = #imageLiteral(resourceName: "right-arrow")
        imageView.tintColor = .black
        return imageView
    }()

    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var previewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var arrayPreviewImageViews: [PreviewImageView] = {
        return [PreviewImageView]()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
//        guard let arrayPreviewImageViews = arrayPreviewImageViews else { return }
        contentView.addSubviews(titleStackView, previewStackView)
        titleStackView.addArrangedSubviews(titleLabel, detailedImage)
        previewStackView.addArrayImageView(arrayPreviewImageViews)
    }
    
    private func setupLayouts() {
//        guard let arrayPreviewImageViews = arrayPreviewImageViews else { return }
        
        let constraints = [
            titleStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            detailedImage.heightAnchor.constraint(equalToConstant: 25),
            detailedImage.widthAnchor.constraint(equalTo: detailedImage.heightAnchor),
            
            previewStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 12),
            previewStackView.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            previewStackView.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor),
            previewStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            contentView.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func takeStackImage(_ images: [UIImage?]) {
        var stackImageView = [PreviewImageView]()
        for image in images {
            let previewImageView = PreviewImageView(image: image)
            stackImageView.append(previewImageView)
        }
        
        arrayPreviewImageViews = stackImageView
    }
}

final class PreviewImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
        clipsToBounds = true
        toAutoLayout()
        contentMode = .scaleAspectFill
        layer.cornerRadius = 6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
