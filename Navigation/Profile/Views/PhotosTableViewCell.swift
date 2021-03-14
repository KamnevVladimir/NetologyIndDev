import UIKit

final class PhotosTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Photos"
        return label
    }()
    
    private lazy var detailedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "right-arrow")
        imageView.tintColor = .black
        return imageView
    }()

    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var previewStackView: UIStackView = {
        let stackView = UIStackView()
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
        titleStackView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(12)
        }
        
        detailedImage.snp.makeConstraints { (make) in
            make.size.equalTo(25)
        }
        
        previewStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(titleStackView)
            make.top.equalTo(titleStackView.snp.bottom).inset(-12)
            make.bottom.equalToSuperview().inset(12)
        }
        
        arrayPreviewImageViews[0].snp.makeConstraints { (make) in
            make.height.equalTo(arrayPreviewImageViews[0].snp.width)
        }
    }
}

private final class PreviewImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
        clipsToBounds = true
        contentMode = .scaleAspectFill
        layer.cornerRadius = 6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
