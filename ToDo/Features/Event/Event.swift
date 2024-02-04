//
//  Event.swift
//  ToDo
//
//  Created by Felipe Assis on 30/01/24.
//

import Foundation
import SwiftData

@Model
class Event {
    var name: String
    var location: String
    var notes = [Note]()
    
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
    
}
