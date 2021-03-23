import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var image: UIImage? {
        didSet {
            photoImageView.image = image
        }
    }
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(photoImageView)
    }
    
    private func setupLayouts() {
        photoImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
