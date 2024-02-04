//
//  Task.swift
//  ToDo
//
//  Created by Felipe Assis on 29/01/24.
//

import Foundation
import SwiftData

@Model
class Note {
    var title: String
    var details: String
    var event: Event?
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, details: String, event: Event? = nil) {
        self.title = name
        self.details = details
        self.event = event
    }
}
