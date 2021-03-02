//
//  MessageVM.swift
//  SlackReader
//
//  Created by Nick Romano on 3/2/21.
//

import Foundation

class MessageVM {
    var message: Message
    
    init(message: Message) {
        self.message = message
    }
    
    func getTheme() -> String {
        var split2: [String] = []
        
        let split1 = message.text.components(separatedBy: "\n&gt")
        for comp in split1 {
            if comp.starts(with: ";Theme") {
                
                split2.append(comp)
            } else if comp.starts(with: "; theme:") {
                split2.append(comp)
            }
        }
        if split2.count > 0 {
            return split2[0].components(separatedBy: "`")[1]
        }
        return ""
    }
}
