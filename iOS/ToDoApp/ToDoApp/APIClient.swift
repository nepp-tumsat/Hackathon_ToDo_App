//
//  APIClient.swift
//  ToDoApp
//
//  Created by 内山和輝 on 2022/06/19.
//

import Foundation

final class APIClient {
    static func getToDoListAPI() {
        let url = URL(string: "http://localhost:8080/users/1/tasks")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url!) { (data, responds, error) in
            if let error = error {
                print("情報の取得に失敗しました。:", error)
                return
            }
            
            if let data = data  {
                do {
                    let taskList:[TaskData] = try JSONDecoder().decode([TaskData].self, from: data)
                    
                    print("json:", taskList)
                } catch {
                    print("デコードに失敗しました。:", error)
                }
            }
        }
        task.resume()
    }
}
