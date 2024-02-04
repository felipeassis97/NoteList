//
//  Previwer.swift
//  ToDo
//
//  Created by Felipe Assis on 01/02/24.
//

import Foundation
import SwiftData

@MainActor
struct Previwer {
    let container: ModelContainer
    let event: Event
    let task: Note
    
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Note.self, configurations: config)
        
        event = Event(name: "Prova", location: "Escola São João")
        task = Note(name: "Avaliação", details: "Matemática", event: event)
        
        container.mainContext.insert(task)
    }
    
}


