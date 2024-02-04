//
//  ToDoApp.swift
//  ToDo
//
//  Created by Felipe Assis on 29/01/24.
//

import SwiftUI
import SwiftData

@main
struct ToDoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Note.self)
    }
}
