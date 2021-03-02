//
//  SlackReaderApp.swift
//  SlackReader
//
//  Created by Nick Romano on 3/2/21.
//

import SwiftUI

@main
struct SlackReaderApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear() {
                    let messages = FileParser.shared.loadMessages()
                    let messageVMs = messages.map {
                        MessageVM(message: $0)
                    }
                    
                    var themeSet = Set<String>()
                    var themes = messageVMs.map { message in
                        themeSet.insert(message.getTheme())
                    }
                    for theme in themeSet {
                        print(theme)
                    }
                    print(themeSet.count)
                }
        }
    }
}
