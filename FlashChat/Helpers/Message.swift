//
//  Message.swift
//  FlashChat
//
//  Created by McKenzie Macdonald on 8/23/22.
//

import Foundation

struct Message {
    
    let sender: String
    let body: String
    let date: Date
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy hh:mm"
        return formatter.string(from: date)
    }
}
