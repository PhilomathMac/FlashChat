//
//  Constants.swift
//  FlashChat
//
//  Created by McKenzie Macdonald on 8/23/22.
//

import Foundation

struct K {
    
    static let appName = "⚡️FlashChat"
    static let registerSegue = "registerToChat"
    static let loginSegue = "loginToChat"
    
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageTableViewCell"
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
    struct BrandColors {
        static let darkBlue = "BrandBlue"
        static let lightBlue = "BrandLightBlue"
        static let darkOrange = "BrandOrange"
        static let lightOrange = "BrandLightOrange"
    }
    
}
