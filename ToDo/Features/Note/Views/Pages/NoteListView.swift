//
//  NoteListView.swift
//  ToDo
//
//  Created by Felipe Assis on 04/02/24.
//

import SwiftUI
import SwiftData

struct NoteListView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\Note.title)]
    
    var body: some View {
        NavigationStack(path: $path) {
            NoteView(searchString: searchText, sortOrder: sortOrder)
                .navigationTitle("Notes")
                .navigationBarTitleDisplayMode(.large)
                .navigationDestination(for: Note.self) { task in
                    EditNoteView(task: task, navigationPath: $path)
                }
                .toolbar {
                    EditButton()
                        .foregroundStyle(.primaryRed)
                        .font(.customStyle(type: .lexend, style: .semiBold, size: 14))
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name (A-Z)")
                                .tag([SortDescriptor(\Note.title)])
                                .font(.customStyle(type: .lexend, style: .regular, size: 14))

                            Text("Name (Z-A)")
                                .tag([SortDescriptor(\Note.title, order: .reverse)])
                                .font(.customStyle(type: .lexend, style: .regular, size: 14))
                        }
                    }

                    
                    Button(action: addTask) {
                            Image(systemName: "plus")
                            .font(.customStyle(type: .lexend, style: .regular, size: 16))
                    }
                }
                .searchable(text: $searchText)
        }
    }
    
    func addTask() {
        let task = Note(name: "", details: "")
        modelContext.insert(task)
        path.append(task)
    }
}

#Preview {
        do {
            let previwer = try Previwer()
            return NoteListView()
                .modelContainer(previwer.container)
        }
        catch {
            return Text("Error to create preview: \(error.localizedDescription)")
        }
}
