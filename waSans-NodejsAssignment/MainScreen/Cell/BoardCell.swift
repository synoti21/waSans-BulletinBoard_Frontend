//
//  CollectionViewCell.swift
//  waSans-NodejsAssignment
//
//  Created by 안지완 on 2023/01/13.
//
import Foundation
import SnapKit
import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class BoardCell: UICollectionViewCell {
    let boardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let boardTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15.0)
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.minimumScaleFactor = 0.2
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addView()
        setLayout()
        setAttributes()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView(){
        [boardImage, boardTitle].forEach({
            contentView.addSubview($0)
        })
    }
    
    private func setLayout(){
        boardImage.snp.makeConstraints{
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(49)
        }
        
        boardTitle.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(12)
            $0.top.equalTo(boardImage.snp.bottom).offset(6)
        }
    }
    
    private func setAttributes(){
        contentView.backgroundColor = .white
        contentView.layer.borderColor = UIColor.lineColor.cgColor
        contentView.layer.cornerRadius = 20.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.masksToBounds = true
    }
    
    func setup(with board: BoardModel){
        boardImage.image = UIImage(named: board.boardImageName)
        boardTitle.text = board.boardTitle
    }
}

extension BoardCell: ReusableView{
    static var identifier: String {
        return String(describing: self)

    }
   
}
