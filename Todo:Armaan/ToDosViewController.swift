//
//  ViewController.swift
//  Todo:Armaan
//
//  Created by Amit on 08/10/19.
//  Copyright © 2019 Amit. All rights reserved.
//

import UIKit

class ToDosViewController: UITableViewController {

    var list = ["Harish","Amit","Armaan"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    
    
    //MARK: Add new items
    @IBAction func onAddNewitemClicked(_ sender: UIBarButtonItem) {
        var mTextField = UITextField()
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ADD", style: .default) { (action) in
//            print("click working")
            if mTextField.text?.isEmpty ?? false {
            }else{
                self.list.append(mTextField.text!)
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
    
}

