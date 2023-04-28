//
//  SearchByOrderCollectionViewCell.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/17.
//

import UIKit
import SnapKit

class PostTypeCollectionViewCell: UICollectionViewCell {
    
    let postTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18.0)
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
        contentView.layer.cornerRadius = 20.0
        contentView.layer.cornerCurve = .continuous
        contentView.layer.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
        contentView.addSubview(postTypeLabel)
        
        postTypeLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
    }
    func setup(with type: String) {
        postTypeLabel.text = type
    }
    
    
    
    
}
extension PostTypeCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
