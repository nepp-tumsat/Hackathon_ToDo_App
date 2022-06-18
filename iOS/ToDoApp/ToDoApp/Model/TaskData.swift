//
//  TaskData.swift
//  ToDoApp
//
//  Created by 内山和輝 on 2022/06/19.
//

import Foundation

struct TaskData: Codable {
//    let id: String
    let userid: String
    let task: String
    let exp: String
    let due: String
    let done: String
}
