import UIKit

final class ProfileTableViewCell: UITableViewCell {
    var post: ModelPost? {
        didSet {
            guard let safePost = post else { return }
            titleLabel.text = safePost.author
            postImageView.image = UIImage(named: safePost.image)
            descriptionLabel.text = safePost.description
            likesLabel.text = "Likes: " + String(safePost.likes)
            viewsLabel.text = "Views: " + String(safePost.views)
        }
    }

    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        title.textColor = .black
        title.numberOfLines = 2
        return title
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.text = "Likes: "
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.text = "Views: "
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        horizontalStackView.addArrangedSubviews(likesLabel, viewsLabel)
        contentView.addSubviews(titleLabel, postImageView, descriptionLabel, horizontalStackView)
    }
    
    private func setupLayouts() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }

        postImageView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).inset(-12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(postImageView.snp.width)
        }

        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(postImageView.snp.bottom).inset(-16)
            make.trailing.leading.equalTo(titleLabel)
        }

        horizontalStackView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).inset(-16)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
