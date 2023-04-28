//
//  ViewController.swift
//  waSans-NodejsAssignment
//
//  Created by 안지완 on 2023/01/13.
//
import SnapKit
import UIKit

class MainScreenViewController: UIViewController {
    
    let boardContext = BoardModelArray().getBoardArray()
    
    let waTitle: UILabel = {
        let label = UILabel()
        label.text = "와"
        label.font = .boldSystemFont(ofSize: 50.0)
        label.textColor = .white
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        
        return label
    }()
    
    let mainFrame: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20.0
        
        return view
    }()
    
    let sansTItle: UILabel = {
        let label = UILabel()
        label.text = "샌즈!"
        label.textColor = .primaryColor
        label.font = .boldSystemFont(ofSize: 35.0)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        
        return label
    }()
    
    let bulletinCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 14
        flowLayout.minimumInteritemSpacing = 14
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.collectionViewLayout = flowLayout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    let newPostButton: UIButton = {
        let button = UIButton()
        button.setTitle("새 게시글", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primaryColor
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: 18.0)
        button.layer.cornerRadius = 20.0
        button.layer.cornerCurve = .continuous
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addView()
        setLayout()
        setAttributes()
        
    }
    
    
    private func setupCollectionView(){
        bulletinCollectionView.delegate = self
        bulletinCollectionView.dataSource = self
        bulletinCollectionView.register(BoardCell.self, forCellWithReuseIdentifier: BoardCell.identifier)
    }

    private func addView(){
        [waTitle, mainFrame].forEach({
            view.addSubview($0)
        })
        
        [sansTItle, bulletinCollectionView, newPostButton].forEach({
            mainFrame.addSubview($0)
        })
    }
    
    private func setLayout(){
        waTitle.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainFrame.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(waTitle.snp.bottom).offset(35)
        }
        mainFrame.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        sansTItle.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(23)
        }
        
        bulletinCollectionView.snp.makeConstraints{
            $0.top.equalTo(sansTItle.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        
        newPostButton.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.snp.bottom).offset(-30)
        }
    
        newPostButton.heightAnchor.constraint(equalTo: newPostButton.widthAnchor, multiplier: 60/350).isActive = true
        
        newPostButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func setAttributes(){
        view.backgroundColor = .primaryColor
    }
    
    @objc private func didTapButton(){
        let navVc = NewPostViewController()
        self.navigationController?.pushViewController(navVc, animated: true)
    }

}




extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCell.identifier, for: indexPath) as! BoardCell
        
        let boardContext = boardContext[indexPath.row]
        cell.setup(with: boardContext)
        
        return cell
    }
    
}


extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width*(168/390), height: view.frame.width*(157/390))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let navVC = BulletinBoardViewController()
        navVC.boardTitle = boardContext[indexPath.row].boardTitle
        self.navigationController?.pushViewController(navVC, animated: true)
        
    }
    
}
