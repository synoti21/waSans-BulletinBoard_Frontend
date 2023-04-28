//
//  BoardList.swift
//  waSans-NodejsAssignment
//
//  Created by 안지완 on 2023/01/14.
//

import UIKit


struct PostModel: Decodable {
    let tag: [String]
    let date: Int
    let writer, title, context: String
}


struct PostListModel: Decodable {
    let postArr: [String]
    let postNumber: Int
}

