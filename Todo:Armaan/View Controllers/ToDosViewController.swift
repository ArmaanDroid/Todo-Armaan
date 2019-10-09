//
//  ViewController.swift
//  Todo:Armaan
//
//  Created by Amit on 08/10/19.
//  Copyright © 2019 Amit. All rights reserved.
//

import UIKit

class ToDosViewController: UITableViewController {
    let KEY_LIST = "todo_list"
    let userDefaults = UserDefaults.init()
    let pListAddress = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Todo.plist")
    
    var list = [ToDoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
        
        print(pListAddress)
    }
    
    //MARK: TableViewController Data Source method
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell",for: indexPath)
        let currentTodo = list[indexPath.row]
        cell.textLabel?.text = currentTodo.task
        cell.accessoryType = currentTodo.completed ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark ? .none : .checkmark
       
        list[indexPath.row].completed = !list[indexPath.row].completed
        
        updateList()

        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    //MARK: Add new items
    @IBAction func onAddNewitemClicked(_ sender: UIBarButtonItem) {
        var mTextField = UITextField()
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ADD", style: .default) { (action) in
            if let task = mTextField.text {
                let todo = ToDoItem.init()
                todo.task = task
                self.list.append(todo)
                self.updateList()
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Please enter a item todo."
            mTextField=textField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func updateList(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(list)
            try data.write(to: pListAddress)
        }catch{
            print("error saving data in plist \(error)")
        }
    }
    
    func loadData(){
        if let data = try? Data(contentsOf: pListAddress){
            let decoder = PropertyListDecoder()
            do{
               list = try decoder.decode([ToDoItem].self, from: data)
            }catch{
                print("error loading data from the plist /(error)")
            }
        }
        
    }
}

