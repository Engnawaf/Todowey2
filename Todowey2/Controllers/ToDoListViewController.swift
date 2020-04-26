//
//  ViewController.swift
//  Todowey2
//
//  Created by Nawaf Al-Failakawy on 4/12/20.
//  Copyright © 2020 Nawaf Al-Failakawy. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
//        let newItem = Item()
//        newItem.title = "Nawaf"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Khalid"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Othman"
//        itemArray.append(newItem3)
        
        loadItem()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            
//            cell.accessoryType = .checkmark
//            
//        } else {
//            
//            cell.accessoryType = .none
//            
//        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print(itemArray[indexPath.row])
        
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            
            self.saveItems()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = " Create New Item"
            
            textField = alertTextField
            
        
        
        }
        
        
        alert.addAction(action)
         present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
        
            let data = try encoder.encode(itemArray)
            
            try data.write(to: dataFilePath!)
            
        }
        catch {
            
            print("Error encoding item array, /(error)")
            
        }
        
        self.tableView.reloadData()

    }
    
    func loadItem(){
        
        if  let data = try? Data(contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            
            do {
            
            itemArray = try decoder.decode([Item].self, from: data)
                
            } catch {
                
                print("Error Decodeing")
            }
        }
    }
    
}


