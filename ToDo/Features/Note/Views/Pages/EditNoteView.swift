//
//  EditTaskView.swift
//  ToDo
//
//  Created by Felipe Assis on 29/01/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditNoteView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var task: Note
    @Binding var navigationPath: NavigationPath
    @State private var selectedPhoto: PhotosPickerItem?
    
    @Query(sort: [
        SortDescriptor(\Event.name),
        SortDescriptor(\Event.location)
    ]) var events: [Event]
    
    var body: some View {
        Form {
            
            if let imageData = task.photo, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }
            
            Section {
                PhotosPicker(selection: $selectedPhoto, matching: .images) {
                    Label("Select a photo", systemImage: "person")
                }
            }
            
            Section {
                TextField("Title", text: $task.title)
                    .textContentType(.name)
            }
            Section {
                TextField("Description", text: $task.details, axis: .vertical)
            }
            
            Section("What event?") {
                Picker("Event", selection: $task.event) {
                    Text("Unknown event")
                        .tag(Optional<Event>.none)
                    
                    if events.isEmpty == false {
                        Divider()
                        ForEach(events) { event in
                            Text(event.name)
                            
                                .tag(Optional(event))
                        }
                    }
                }
                
                Button("Add a new event", action: addEvent)
            }
        }
        .navigationTitle("Edit")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Event.self) { event in
            EditEventView(event: event)
        }
        .onChange(of: selectedPhoto, loadPhoto)
        
    }
    
    func loadPhoto() {
        Task {
            @MainActor in
            task.photo = try await selectedPhoto?.loadTransferable(type: Data.self)
        }
    }
    
    func addEvent() {
        let event = Event(name: "", location: "")
        modelContext.insert(event)
        navigationPath.append(event)
    }
}

#Preview {
    do {
        let previwer = try Previwer()
        return EditNoteView(task: previwer.task,
                        navigationPath: .constant(NavigationPath()))
        .modelContainer(previwer.container)
    }
    catch {
        return Text("Error to create preview: \(error.localizedDescription)")
    }
}
