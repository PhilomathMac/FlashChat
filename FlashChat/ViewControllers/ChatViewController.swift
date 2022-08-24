//
//  ChatViewController.swift
//  FlashChat
//
//  Created by McKenzie Macdonald on 8/22/22.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var logOutButton: UIBarButtonItem!
    
    var messages = [Message]()
    
    let db = Firestore.firestore()
    var listener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        title = K.appName
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages() {
        // Clear dummy messages
        
        listener = db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let snapshotDocs = querySnapshot?.documents else {
                print("Snapshot empty")
                return
            }
            
            self.messages = []
            
            for doc in snapshotDocs {
                let data = doc.data()
                if let sender = data[K.FStore.senderField], let body = data[K.FStore.bodyField], let timestamp : Timestamp = data[K.FStore.dateField] as? Timestamp {
                    
                    let newMessage = Message(sender: sender as! String, body: body as! String, date: timestamp.dateValue())
                    self.messages.append(newMessage)
                    
                    // Update the tableView in the main thread
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    
                }
            }
            
        }
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextField.text, let sender = Auth.auth().currentUser?.email {
            
            // Add message to database
            db.collection(K.FStore.collectionName).addDocument(data: [
                
                K.FStore.senderField : sender,
                K.FStore.bodyField : messageBody,
                K.FStore.dateField : Date()
                
            ]) { error in
                
                guard error == nil else {
                    //TODO: Display error to user
                    print(error!.localizedDescription)
                    return
                }
                
                // Clear textfield
                DispatchQueue.main.async {
                    self.messageTextField.text = ""
                    self.loadMessages()
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        if let listener = listener {
            listener.remove()
        }
        
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
    
    /// Set up each new cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        // Dequeu a cell
        let newCell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)  as! MessageTableViewCell
        
        // Set up the cell properties
        newCell.messageLabel.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            // This message was sent by me
            newCell.leftImageView.isHidden = true
            newCell.rightImageView.isHidden = false
            newCell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.darkBlue)
            newCell.messageLabel.textColor = .white
            
        } else {
            // This message was sent by someone else
            newCell.leftImageView.isHidden = false
            newCell.rightImageView.isHidden = true
            newCell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightOrange)
            newCell.messageLabel.textColor = UIColor(named: K.BrandColors.darkBlue)
        }
        
        // Return the cell
        return newCell
        
    }
    
}

/*
 MY ORGINAL SOLUTION TO ORDERING DATA FROM FIRESTORE BY DATE
 
 if let sender = data[K.FStore.senderField], let body = data[K.FStore.bodyField], let timestamp : Timestamp = data[K.FStore.dateField] as? Timestamp {
     
     let newMessage = Message(sender: sender as! String, body: body as! String, date: timestamp.dateValue())
     self.messages.append(newMessage)
     self.messages = self.messages.sorted { message1, message2 in
         
         return message1.date < message2.date
         
     }
     
     // Update the tableView in the main thread
     DispatchQueue.main.async {
         self.tableView.reloadData()
     }
     
 }
 */
