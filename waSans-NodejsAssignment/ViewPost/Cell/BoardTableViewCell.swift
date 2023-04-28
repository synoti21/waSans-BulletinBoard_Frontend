//
//  BoardTableViewCell.swift
//  waSans-NodejsAssignment
//
//  Created by 안지완 on 2023/01/15.
//

import UIKit
import SnapKit

class BoardTableViewCell: UITableViewCell {
    
    let boardImage: UIImageView = {
        let sansImage = UIImage(named: "announcement")
        
        let imageView = UIImageView(image: sansImage)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var boardTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30.0)
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.minimumScaleFactor = 0.2
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout(){
        [boardImage, boardTitle].forEach({
            contentView.addSubview($0)
        })
        
        boardImage.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(21)
            $0.leading.equalToSuperview().inset(20)
        }
        boardImage.widthAnchor.constraint(equalTo: boardImage.heightAnchor).isActive = true
        
        boardTitle.snp.makeConstraints{
            $0.leading.equalTo(boardImage.snp.trailing).offset(20.88)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setup(with postTitle: String){
        boardTitle.text = postTitle
    }
    
}
