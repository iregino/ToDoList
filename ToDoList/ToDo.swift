//
//  ToDo.swift
//  ToDoList
//
//  Created by student14 on 4/2/19.
//  Copyright © 2019 student14. All rights reserved.
//

import Foundation

struct ToDo {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static func loadToDos() -> [ToDo]? {
        return nil
    }
    
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "To Do One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "To Do Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "To Do Three", isComplete: false, dueDate: Date(), notes: "Notes 3")
        
        return [todo1,todo2, todo3]
    }
}
