//
//  TableViewController.swift
//  Example
//
//  Created by Mohammad Nabulsi on 11/7/17.
//  Copyright © 2017 JNDisrupter. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set footer view
        self.tableView.tableFooterView = UIView()
        
        // Set navigation item back button
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowExample", sender: indexPath.row)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? ViewController , segue.identifier == "ShowExample" , let index = sender as? Int {
            destination.itemIndex = index
        }
    }
}
