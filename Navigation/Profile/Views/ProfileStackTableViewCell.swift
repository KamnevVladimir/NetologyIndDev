import UIKit

final class ProfileStackTableViewCell: UITableViewCell {
    
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
    
    private lazy var imageView1 = PreviewImageView(frame: .zero)
    private lazy var imageView2 = PreviewImageView(frame: .zero)
    private lazy var imageView3 = PreviewImageView(frame: .zero)
    private lazy var imageView4 = PreviewImageView(frame: .zero)
    
    private lazy var arrayImageView: [UIImageView] = {
        var arrayImageView = [UIImageView]()
        arrayImageView.append(imageView1)
        arrayImageView.append(imageView2)
        arrayImageView.append(imageView3)
        arrayImageView.append(imageView4)
        return arrayImageView
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
        for imageView in arrayImageView {
            previewStackView.addArrangedSubview(imageView)
        }
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
    
    func takeStackImage(post: ProfilePost) {
        for index in 0...post.imageStack.count - 1 {
            let image = UIImage(named: post.imageStack[index])
            arrayImageView[index].image = image
        }
    }
}

private final class PreviewImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        toAutoLayout()
        clipsToBounds = true
        contentMode = .scaleAspectFill
        layer.cornerRadius = 6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
