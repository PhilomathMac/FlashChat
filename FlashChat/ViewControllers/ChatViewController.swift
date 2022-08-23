//
//  ChatViewController.swift
//  FlashChat
//
//  Created by McKenzie Macdonald on 8/22/22.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var logOutButton: UIBarButtonItem!
    
    var messages = [
        Message(sender: "Test@test.com", body: "Hey"),
        Message(sender: "Test1@test.com", body: "Hello"),
        Message(sender: "Test1@test.com", body: "Are you hungry?"),
        Message(sender: "Test@test.com", body: "Very"),
        Message(sender: "Test1@test.com", body: "ASDFHGJFKLSDKUDFHJKSL! SOOOO HUNGRY!")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        title = K.appName
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }

}

// MARK: - TableViewDataSource

extension ChatViewController: UITableViewDataSource {
    
    /// Return the number of messages to show
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeu a cell
        var newCell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)  as! MessageTableViewCell
        
        // Set up the cell properties
        newCell.messageLabel.text = messages[indexPath.row].body
        
        // Return the cell
        return newCell
        
    }
    
}
