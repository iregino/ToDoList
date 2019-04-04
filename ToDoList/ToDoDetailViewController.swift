//
//  ToDoDetailViewController.swift
//  ToDoList
//
//  Created by student14 on 4/2/19.
//  Copyright © 2019 student14. All rights reserved.
//

import UIKit

class ToDoDetailViewController: UITableViewController {
    
    //Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //Variables
    var isDatePickerHidden = true
    var todo: ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load todo details on the view page
        if let todo = todo {
            navigationItem.title = "To Do Item"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
        
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
        
    } //end viewDidLoad()
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    } //end textEditingChanged()
    
    func updateSaveButtonState() {
        // Grab value from text field to a local variable
        let text = titleTextField.text ?? ""
        // Enable save button if text field is not empty
        saveButton.isEnabled = !text.isEmpty
    } //end updateSaveButtonState()
    
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    } //end returnPressed()
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        // Uncheck/check button when user taps on it
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    } //end isCompleteButtonTapped()
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    } //end datePickerChanged()
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    } //end updateDueDateLabel()
    
    
    // MARK: - Table view data source

    // Adjust row height for due date cell and notes cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch (indexPath) {
        case [1,0]: //Due Date Cell
            return isDatePickerHidden ? normalCellHeight : largeCellHeight
        case [2,0]: //Notes Cell
            return largeCellHeight
        default:
            return normalCellHeight
        } //end switch
    } // end tableView(:heighForRowAt:)
    
    // Update tableView when due date is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath) {
        case [1,0]:
            isDatePickerHidden = !isDatePickerHidden
            dueDateLabel.textColor = isDatePickerHidden ? .black : tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    } //end tableView(:didSelectRowAt:)
    
    
    // MARK: - Navigation

    // Preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text!
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    } //end prepare(for segue:)


} //end ToDoDetailViewController{}
