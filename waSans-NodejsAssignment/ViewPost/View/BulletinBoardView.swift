//
//  BulletinBoardViewController.swift
//  waSans-NodejsAssignment
//
//  Created by 안지완 on 2023/01/14.
//

import UIKit
import SnapKit

class BulletinBoardViewController: UIViewController {
    
    let boardService = BoardService()
    
    var boardTitle: String?
    
    var postList = Array<PostModel>()
    var postCnt: Int?
        
    
    let boardLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30.0)
        label.textColor = .black
        
        return label
    }()
    
    
    let boardTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lineColor
        tableView.isScrollEnabled = true
        
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        Task{
            await loadData()
            setupDelegate()
            addView()
            setLayout()
            setAttributes()
        }
        
    }
    
    private func addView(){
        [boardLabel, boardTableView].forEach({
            view.addSubview($0)
        })
    }
    
    private func setLayout(){
        boardLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        boardTableView.snp.makeConstraints{
            $0.top.equalTo(boardLabel.snp.bottom).offset(31)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setAttributes()  {
        view.backgroundColor = .white
        boardLabel.text = boardTitle
    }
    
    private func setupDelegate(){
        boardTableView.dataSource = self
        boardTableView.delegate = self
        boardTableView.register(BoardTableViewCell.classForCoder(), forCellReuseIdentifier: "cellIdentifier")
    }
    private func loadData() async {
        var postTitleList = Array<String>()
        
        var boardType: String
        
        switch(boardTitle){
        case "공지사항":
            boardType = "announcement"
        case "자유 게시판":
            boardType = "freeboard"
        case "질문과 답변":
            boardType = "qa"
        default:
            boardType = ""
        }
        
        do{
                let responseData = try await boardService.getPostList(boardType)
                postCnt = responseData.postNumber
                postTitleList = responseData.postArr
                print("postTitleList = \(postTitleList)")
                if let postCount = postCnt{
                    for x in 0..<postCount{
                        let postData = try await boardService.getPostData(boardType, postTitleList[x])
                        postList.append(postData)
                        print(postData)
                    }
                }else{
                    return
                }
                
                            
            
                
        }catch{
            print(error)
        }
        
        
    }
}

extension BulletinBoardViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("sadfasd")
        return postCnt ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = boardTableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! BoardTableViewCell
        
        cell.setup(with: postList[indexPath.row].title)
        print("setup")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width * (109/350)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let navVC = PostViewController()
        navVC.targetPost = postList[indexPath.row]
        self.navigationController?.pushViewController(navVC, animated: true)
    }
    
}
