//
//  boardModel.swift
//  waSans-NodejsAssignment
//
//  Created by 안지완 on 2023/01/13.
//

import Foundation


struct BoardModel{
    let boardImageName: String
    let boardTitle: String
}

struct BoardModelArray{
    let boardArray =
    [BoardModel(boardImageName: "announcement", boardTitle: "공지사항"),
     BoardModel(boardImageName: "freeboard", boardTitle: "자유 게시판"),
     BoardModel(boardImageName: "qa", boardTitle: "질문과 답변")
    ]
    
    func getBoardArray() -> [BoardModel]{
        return boardArray
    }
}
