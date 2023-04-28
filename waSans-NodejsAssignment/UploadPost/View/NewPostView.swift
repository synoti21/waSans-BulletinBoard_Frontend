//
//  NewPostViewController.swift
//  waSans-NodejsAssignment
//
//  Created by 안지완 on 2023/01/20.
//

import UIKit
import SnapKit

class NewPostViewController: UIViewController, UITextViewDelegate {
    
    let boardSerivce = BoardService()
    
    var selectedPostType = "announcement"
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.text = "새 게시글 작성"
        label.font = .boldSystemFont(ofSize: 30.0)
        label.textColor = .black
        
        return label
    }()
    
    let titleField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목"
        textField.font = .systemFont(ofSize: 18.0)
        textField.textColor = .black
        textField.textAlignment = .left
        textField.adjustsFontForContentSizeCategory = true
        
        return textField
    }()
    
    let titleFieldLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lineColor
        
        return view
    }()
    
    let writerField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "작성자"
        textField.font = .systemFont(ofSize: 18.0)
        textField.textColor = .black
        textField.textAlignment = .left
        textField.adjustsFontForContentSizeCategory = true
        
        return textField
    }()
    
    let writerFieldLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lineColor
        
        return view
    }()
    
    let contextField: UITextView = { ///textfield는 여러 줄 처리가 불가능하므로 textView로 대체
        let textView = UITextView()
        
        textView.isEditable = true
        textView.layer.borderColor = UIColor.lineColor.cgColor
        textView.font = UIFont.systemFont(ofSize: 18.0)
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 20.0
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12);

        
        return textView
    }()
    
    let dateField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "날짜 (ex. 20201020)"
        textField.font = .systemFont(ofSize: 18.0)
        textField.textColor = .black
        textField.textAlignment = .left
        textField.adjustsFontForContentSizeCategory = true
        
        return textField
    }()
    
    let dateFieldLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lineColor
        
        return view
    }()
    
    let tagField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "태그 (쉼표로 구분)"
        textField.font = .systemFont(ofSize: 18.0)
        textField.textColor = .black
        textField.textAlignment = .left
        textField.adjustsFontForContentSizeCategory = true
        
        return textField
    }()
    
    let tagFieldLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lineColor
        
        return view
    }()
    
    let uploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("새 게시글 등록하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18.0)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 20.0
        button.backgroundColor = .primaryColor
        
        return button
    }()
    
    let postTypeView: UICollectionView = {
        let viewLayout = LeftAlignedCollectionViewFlowLayout()
        viewLayout.minimumInteritemSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: viewLayout)
        collectionView.isScrollEnabled = false
        collectionView.collectionViewLayout = viewLayout
        collectionView.backgroundColor = .white
        collectionView.allowsMultipleSelection = false
        
        return collectionView
    }()
    
    let postTypeArr: [String] = [
        "공지사항", "자유게시판", "질문과 답변"
    ]
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        addView()
        setLayout()
        setAttributes()

        // Do any additional setup after loading the view.
    }
    
    private func setupDelegate(){
        postTypeView.delegate = self
        postTypeView.dataSource = self
        postTypeView.register(PostTypeCollectionViewCell.self, forCellWithReuseIdentifier: PostTypeCollectionViewCell.identifier)
    }
    
    private func addView(){
        [pageTitle, titleField, titleFieldLine, writerField, writerFieldLine, contextField, dateField, dateFieldLine, tagField, tagFieldLine, uploadButton, postTypeView].forEach({
            view.addSubview($0)
        })
        
        contextField.delegate = self
    }
    
    private func setLayout(){
        pageTitle.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(20)
        }
        
        titleField.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(pageTitle.snp.bottom).offset(43)
        }
        
        titleField.heightAnchor.constraint(equalTo: titleField.widthAnchor, multiplier: 22/350).isActive = true
        
        titleFieldLine.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(titleField.snp.bottom).offset(7)
            $0.height.equalTo(1)
        }
        
        writerField.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(titleFieldLine.snp.bottom).offset(21)
        }
        
        writerField.heightAnchor.constraint(equalTo: writerField.widthAnchor, multiplier: 22/350).isActive = true
        
        writerFieldLine.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(writerField.snp.bottom).offset(7)
            $0.height.equalTo(1)
        }
        
        contextField.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(writerFieldLine.snp.bottom).offset(21)
        }
        contextField.heightAnchor.constraint(equalTo: contextField.widthAnchor, multiplier: 197/350).isActive = true
        
        dateField.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(contextField.snp.bottom).offset(21)
        }
        
        dateField.heightAnchor.constraint(equalTo: dateField.widthAnchor, multiplier: 22/350).isActive = true
        
        dateFieldLine.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(dateField.snp.bottom).offset(7)
            $0.height.equalTo(1)
        }
        
        tagField.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(dateFieldLine.snp.bottom).offset(21)
        }
        
        tagField.heightAnchor.constraint(equalTo: tagField.widthAnchor, multiplier: 22/350).isActive = true
        
        tagFieldLine.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(tagField.snp.bottom).offset(7)
            $0.height.equalTo(1)
        }
        
        postTypeView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(tagFieldLine.snp.bottom).offset(36)
        }
        postTypeView.heightAnchor.constraint(equalTo: postTypeView.widthAnchor, multiplier: 35/350).isActive = true
        
        uploadButton.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(30)
        }
        uploadButton.heightAnchor.constraint(equalTo: uploadButton.widthAnchor, multiplier: 60/350).isActive = true
        
        contextField.text = "내용 입력"
        contextField.textColor = .lineColor
        
        uploadButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        
    }
    
    private func setAttributes(){
        view.backgroundColor = .white
    }
    
    @objc private func didTapButton(){
        let postDate: Int? = Int(dateField.text ?? "")
        let postTag: [String] = tagField.text?.components(separatedBy: ",") ?? []
        
        
        let targetUploadPost = PostModel(tag: postTag, date: postDate ?? 0, writer: writerField.text ?? "", title: titleField.text ?? "", context: contextField.text ?? "")
        
        print(targetUploadPost)
        print(selectedPostType)
        
        boardSerivce.addPost(selectedPostType, targetDocumnet: targetUploadPost){response in
            if(response){
                let navVc = PostCompleteViewController()
                self.navigationController?.pushViewController(navVc, animated: true)
            }else{
                print("error")
            }
            
        }
        
        
        
        
    }
    
    func textViewDidBeginEditing (_ textView: UITextView) {
        if contextField.textColor == .lineColor && contextField.isFirstResponder {
            contextField.text = nil
            contextField.textColor = .black
        }
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        if contextField.text.isEmpty || contextField.text == "" {
            contextField.textColor = .lineColor
            contextField.text = "내용 입력"
        }
    }

}


extension NewPostViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PostTypeCollectionViewCell.identifier,
            for: indexPath) as! PostTypeCollectionViewCell
        
        let context = postTypeArr[indexPath.row]
        cell.setup(with: context)
        return cell
    }
}

extension NewPostViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as! PostTypeCollectionViewCell
        selectedCell.postTypeLabel.textColor = .white
        selectedCell.contentView.layer.backgroundColor = UIColor.primaryColor.cgColor
        switch(selectedCell.postTypeLabel.text){
        case "공지사항":
            selectedPostType = "announcement"
        case "자유게시판":
            selectedPostType = "freeboard"
        case "질문과 답변":
            selectedPostType = "qa"
        default:
            selectedPostType = ""
            print("error : no selection")
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        didDeselectItemAt indexPath: IndexPath) {
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as! PostTypeCollectionViewCell
        selectedCell.postTypeLabel.textColor = #colorLiteral(red: 0.4862745098, green: 0.4862745098, blue: 0.4862745098, alpha: 1)
        selectedCell.contentView.layer.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var str: String
        
        
        str = postTypeArr[indexPath.row]
        
        let font: UIFont = .systemFont(ofSize: 18.0)
        let size: CGSize = str.size(withAttributes: [NSAttributedString.Key.font: font])
        
        return CGSize(width: size.width+28, height: size.height+14)
    }
}


