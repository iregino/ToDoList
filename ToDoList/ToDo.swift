//
//  ToDo.swift
//  ToDoList
//
//  Created by student14 on 4/2/19.
//  Copyright © 2019 student14. All rights reserved.
//

import Foundation

struct ToDo: Codable {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    // Formats date to a short format
    static var dueDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    // Create directory/archive instance to store saved the todos
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
    
    // Decode saved todos from archive
    static func loadToDos() -> [ToDo]? {
        guard let codedTodos = try? Data(contentsOf: ArchiveURL) else { return nil }
        let properListDecoder = PropertyListDecoder()
        return try? properListDecoder.decode(Array<ToDo>.self, from: codedTodos)
    } //end loadToDos()
    
    // Encode todos and save them to archive
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedTodos = try? propertyListEncoder.encode(todos)
        try? codedTodos?.write(to: ArchiveURL, options: .noFileProtection)
    } //end saveToDos()
    
    // Load sample to do items
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "To Do One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        return [todo1]
    } //end loadSampleToDos()

} //end ToDo{}
