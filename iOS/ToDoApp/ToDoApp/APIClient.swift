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
    
    static func addToDoAPI() {
        var expInt = Int((AddViewController.outputExpText)!)
        print(type(of: expInt))
        
        let url = URL(string: "http://localhost:8080/tasks")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" 
        request.httpBody = "task=\(AddViewController.outputToDoText!)&userid=1&exp=\(expInt!)&due=2022-04-01".data(using: .utf8)
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            print("data: \(String(describing: data))")
            print("response: \(String(describing: response))")
            print("error: \(String(describing: error))")
            print("------------------------------------")
            do{
                let responseData = try JSONSerialization.jsonObject(with: data!, options: [])
                print(responseData)
            }
            catch {
                print(error)
            }
        }).resume()
    }
}
