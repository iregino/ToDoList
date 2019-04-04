//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Ian Regino on 4/2/19.
//  Copyright © 2019 Ian Regino. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    
    //Variables
    var todos = [ToDo]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedToDos = ToDo.loadToDos() {
            todos = savedToDos //load saved todos from documents directory
        }
        
    } //end viewDidLoad
    
    //MARK: - Table Cell Delegate Method
    
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        } //end if-let
    } //end checkmarkTapped()

    
    //MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    } //end numberOfSections()

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    } //end tableView(:numberOfRowsInSection:)

    // Populate table cell with todo values
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") as? ToDoCell else {
            fatalError("Could not dequeue a cell")
        }
        cell.delegate = self
        
        let todo = todos[indexPath.row]
        cell.titleLabel.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete
        return cell
    } //end tableView(:cellForRowAt:)
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    } //end tableView(:canEditRowAt:)
    
    // Delete specific to do item
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //Delete the row from the data source
        if editingStyle == .delete  {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDo.saveToDos(todos)
        } //end if
    } //end tableView(:editingStyle:)


    // MARK: - Navigation
    
    // Save the information passed by segue from from ToDo detail view
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        
        guard segue.identifier == "saveUnwind" else { return }
        let sourceVC = segue.source as! ToDoDetailViewController
        
        if let todo = sourceVC.todo {
            // Save any changes to existing todo item
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Save new todo item
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            } //end if-let
        } //end if-let
        
        ToDo.saveToDos(todos)
    } //end unwindToToDoList()
    
    // Preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetails" {
            let todoDetailVC = segue.destination as! ToDoDetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedToDo = todos[indexPath.row]
            todoDetailVC.todo = selectedToDo
        } //end if-let
    } //end prepare(for segue:)
    

} //end ToDoTableViewController{}
