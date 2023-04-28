//
//  PostModel.swift
//  waSans-NodejsAssignment
//
//  Created by 안지완 on 2023/01/14.
//


import Alamofire
import Foundation

struct BoardService{

    private func makeParameter(document_id : String) -> Parameters {
        return ["DOCUMENT_ID" : document_id]
    }
    
    /*func getPostList(_ type: String, completion: @escaping(PostListModel) -> ()) {
        let url: String = APIConstants.baseURL + "/\(type)/getPostList"
        print(url)
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: nil,
                                     encoding: JSONEncoding.default,
                                     headers: HTTPHeaders()
                                     )
            .validate(statusCode: 200..<500)
            .responseDecodable(of: PostListModel.self) { (response) in
                guard let postData = response.value else {return}
                completion(postData)
            }
    }*/
    
    func getPostList(_ type: String) async throws -> PostListModel {
        
        try await withUnsafeThrowingContinuation{ continuation in
            let url = APIConstants.baseURL + "/\(type)/getPostList"
            print(url)
            
            AF.request(url,
                       method: .post,
                       encoding: JSONEncoding.default,
                       headers: HTTPHeaders())
            .validate()
            .responseDecodable(of: PostListModel.self) { response in
                if let data = response.value {
                    continuation.resume(returning: data)
                    return
                }
                if let err = response.error {
                    continuation.resume(throwing: err)
                    return
                }
                fatalError("Uncaught Error")
            }
        }
    }
    
    
    
    func getPostData(_ type: String, _ id: String) async throws -> PostModel{
        /*let url: String = APIConstants.baseURL + "/\(type)/getPostData"
        let dataRequest = AF.request(url,
                                     method: .get,
                                     parameters: makeParameter(document_id: id),
                                     encoding: JSONEncoding.default,
                                     headers: HTTPHeaders()
                                     )
            .validate(statusCode: 200..<500)
            .responseDecodable(of: PostModel.self) { (response) in
                guard let postData = response.value else {return}
                print(postData)
                completion(postData)
            }*/
        
        try await withUnsafeThrowingContinuation{ continuation in
            let url = APIConstants.baseURL + "/\(type)/getPostData"
            print(url)
            
            AF.request(url,
                       method: .get,
                       parameters: makeParameter(document_id: id),
                       encoding: URLEncoding.default,
                       headers: HTTPHeaders())
            .validate()
            .responseDecodable(of: PostModel.self) { response in
                if let data = response.value {
                    continuation.resume(returning: data)
                    return
                }
                if let err = response.error {
                    continuation.resume(throwing: err)

                    return
                }
                fatalError("Uncaught Error")
            }
        }
        
    }
    
    func addPost(_ type: String, targetDocumnet: PostModel, completion: @escaping(Bool) -> ()){
        var request = URLRequest(url: URL(string: "\(APIConstants.baseURL)/\(type)/addPost")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        // POST 로 보낼 정보
        let params = ["title": targetDocumnet.title,
                      "context": targetDocumnet.context,
                      "writer": targetDocumnet.writer,
                      "date": targetDocumnet.date,
                      "tag": targetDocumnet.tag
                    ]
        as Dictionary
        
        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                print("POST 성공")
                completion(true)
            case .failure(let error):
                print("error : \(error.errorDescription!)")
                completion(false)
            }
        }
    }
           
    
    
    
}
