//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: StoryCollectionViewCell.self)
    private var viewModel = StoryCollectionViewModel()
    
    lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 35
        image.clipsToBounds = true
        return image
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = .blue
        button.backgroundColor = .white
        button.layer.cornerRadius = 12.5
        return button
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.buildViewHierarchy()
        self.configContraints()
    }
    
    public func setupCell(_ indexPath: IndexPath, data: Stories) {
        profileImageView.image = UIImage(named: data.image ?? "")
        userNameLabel.text = data.userName
        addButton.isHidden = viewModel.hidenButton(indexPath)
    }
    
    private func buildViewHierarchy() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(addButton)
        contentView.addSubview(userNameLabel)
    }
    
    private func configContraints() {
        profileImageView.anchor(top: topAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0), size: CGSize(width: 70, height: 70))
        profileImageView.xAnchor(xAnchor: centerXAnchor)
        
        addButton.anchor(bottom: profileImageView.bottomAnchor, trailing: profileImageView.trailingAnchor, size: CGSize(width: 25, height: 25))
        
        userNameLabel.anchor(top: profileImageView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
    }
}
