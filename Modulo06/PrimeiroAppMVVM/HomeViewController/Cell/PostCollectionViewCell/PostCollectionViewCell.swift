//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: PostCollectionViewCell.self)
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.setupShadow()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    lazy var likeImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "red-heart")
        image.contentMode = .scaleAspectFill
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedLikeImageView))
        tap.numberOfTapsRequired = 1
        image.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true
        image.isHidden = false
        return image
    }()
    
    @objc func tappedLikeImageView() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.likeImageView.center.y += 50
            self.likeImageView.isHidden = false
        }, completion: { finished in
            self.likeImageView.center.y -= 50
            self.likeImageView.isHidden = true
        })
    }
    
    lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "demo")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.text = "Renato Vieira"
        return label
    }()
    
    lazy var postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedPostImageView))
        tap.numberOfTapsRequired = 2
        image.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    @objc func tappedPostImageView() {
        heartImageView.isHidden = false
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.heartImageView.transform = .init(scaleX: 1.8, y: 1.8)
            self.postImageView.transform = .init(scaleX: 1.05, y: 1.05)
            self.likeImageView.center.y += 50
        } , completion: { finished in
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.postImageView.transform = .identity
                self.likeImageView.center.y -= 50
                self.likeImageView.isHidden = false
            })
            self.heartImageView.transform = .identity
            self.heartImageView.isHidden = true
        })
    }
    
    lazy var heartImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "white")
        image.contentMode = .scaleAspectFill
        //image.isHidden = true
        image.isHidden = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(_ data: Posts) {
        self.profileImageView.image = UIImage(named: data.profileImage ?? "")
        self.userNameLabel.text = data.userName
        self.postImageView.image = UIImage(named: data.postImage ?? "")
    }
    
    private func setup() {
        self.builViewHerarchy()
        self.configConstraints()
    }
    
    private func builViewHerarchy() {
        contentView.addSubview(cardView)
        cardView.addSubview(likeImageView)
        cardView.addSubview(profileImageView)
        cardView.addSubview(userNameLabel)
        cardView.addSubview(postImageView)
        cardView.addSubview(heartImageView)
    }
    
    private func configConstraints() {
        
        cardView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 15))
        
        likeImageView.anchor(top: cardView.topAnchor, trailing: cardView.trailingAnchor, padding: UIEdgeInsets(top: 19, left: 0, bottom: 0, right: 20), size: CGSize(width: 25, height: 25))

        profileImageView.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, padding: UIEdgeInsets(top: 17, left: 20, bottom: 0, right: 0), size: CGSize(width: 30, height: 30))

        userNameLabel.anchor(top: cardView.topAnchor, leading: profileImageView.trailingAnchor, padding: UIEdgeInsets(top: 24, left: 10, bottom: 0, right: 0))

        postImageView.anchor(top: profileImageView.bottomAnchor, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor, padding: UIEdgeInsets(top: 17, left: 7, bottom: 7, right: 7))
        
        heartImageView.xAnchor(xAnchor: postImageView.centerXAnchor)
        heartImageView.yAnchor(yAnchor: postImageView.centerYAnchor)
        heartImageView.size(size: CGSize(width: 70, height: 70))
        
    }
}
