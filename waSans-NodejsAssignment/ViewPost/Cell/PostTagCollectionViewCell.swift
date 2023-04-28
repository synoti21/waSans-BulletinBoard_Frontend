
import Foundation
import SnapKit
import UIKit



// MARK: - 음식 해쉬태그 셀, 카페 해쉬태그 셀, 액티비티 셀 설정
final class PostTagCollectionViewCell: UICollectionViewCell {
    let postTagLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15.0)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.4862745098, green: 0.4862745098, blue: 0.4862745098, alpha: 1)

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){ ///해쉬태그 버튼 모양 설정
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 12.0
        contentView.layer.cornerCurve = .continuous
        contentView.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.8823529412, blue: 0.8823529412, alpha: 1)
        contentView.addSubview(postTagLabel)

        postTagLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
    }
    func setup(with tag: String) { 
        postTagLabel.text = tag
    }
    
}

extension PostTagCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
