//
//  EditEventView.swift
//  ToDo
//
//  Created by Felipe Assis on 30/01/24.
//

import SwiftUI

struct EditEventView: View {
    @Bindable var event: Event
    
    var body: some View {
        Form {
            TextField("Name of event", text: $event.name)
            TextField("Location", text: $event.location)
        }
        .navigationTitle("Edit event")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let previwer = try Previwer()
        return EditEventView(event: previwer.event)
            .modelContainer(previwer.container)
    }
    catch {
        return Text("Error to create preview: \(error.localizedDescription)")
    }
}
