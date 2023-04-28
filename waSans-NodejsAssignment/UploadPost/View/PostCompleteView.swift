//
//  PostCompleteViewController.swift
//  waSans-NodejsAssignment
//
//  Created by 안지완 on 2023/01/20.
//

import SnapKit
import UIKit

class PostCompleteViewController: UIViewController {
    
    let returnMenuButton: UIButton = {
        let button = UIButton()
        button.setTitle("메인화면으로 돌아가기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18.0)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 20.0
        button.backgroundColor = .primaryColor
        
        return button
    }()
    
    let waImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sans"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
    }()
    
    let completeLabel: UILabel = {
        let label = UILabel()
        label.text = "와! 게시글 업로드 성공!"
        label.textAlignment = .center
        label.textColor = .primaryColor
        label.adjustsFontForContentSizeCategory = true
        label.minimumScaleFactor = 0.2
        label.font = .boldSystemFont(ofSize: 30.0)
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
        setAttributes()

        // Do any additional setup after loading the view.
    }
    
    private func addView(){
        [waImage, completeLabel, returnMenuButton].forEach({
            view.addSubview($0)
        })
    }
    
    private func setLayout(){
        waImage.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(190)
        }
        waImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 167/390).isActive = true
        waImage.heightAnchor.constraint(equalTo: waImage.widthAnchor, multiplier: 223/167).isActive = true
        
        completeLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(waImage.snp.bottom).offset(19)
        }
        
        returnMenuButton.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(30)
        }
        returnMenuButton.heightAnchor.constraint(equalTo: returnMenuButton.widthAnchor, multiplier: 60/350).isActive = true
    }
    
    private func setAttributes(){
        view.backgroundColor = .white
        returnMenuButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    


}
