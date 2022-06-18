//
//  TaskData.swift
//  ToDoApp
//
//  Created by 内山和輝 on 2022/06/19.
//

import Foundation

struct TaskData: Codable {
    let id, userid: Int
    let task: String
        let exp: Int
        let due: String
        let done: Bool
}
