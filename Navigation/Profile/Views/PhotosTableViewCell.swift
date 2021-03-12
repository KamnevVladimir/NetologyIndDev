import UIKit

final class PhotosTableViewCell: UITableViewCell {
    
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
        imageView.image = UIImage(systemName: "arrow.right")
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
        var previewImageView1 = PreviewImageView(image: PostImages.images[0])
        var previewImageView2 = PreviewImageView(image: PostImages.images[1])
        var previewImageView3 = PreviewImageView(image: PostImages.images[2])
        var previewImageView4 = PreviewImageView(image: PostImages.images[3])
        
        let arrayImageViews = [previewImageView1, previewImageView2, previewImageView3, previewImageView4]
        return arrayImageViews
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
        contentView.addSubviews(titleStackView, previewStackView)
        titleStackView.addArrangedSubviews(titleLabel, detailedImage)
        previewStackView.addArrayImageView(arrayPreviewImageViews)
    }
    
    private func setupLayouts() {
        let constraints = [
            titleStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            detailedImage.widthAnchor.constraint(equalTo: detailedImage.heightAnchor),
            
            previewStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 12),
            previewStackView.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            previewStackView.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor),
            previewStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            arrayPreviewImageViews[0].heightAnchor.constraint(equalTo: arrayPreviewImageViews[0].widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

class PreviewImageView: UIImageView {
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
