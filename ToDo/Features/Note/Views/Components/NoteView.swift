//
//  TaskView.swift
//  ToDo
//
//  Created by Felipe Assis on 29/01/24.
//

import SwiftUI
import SwiftData

struct NoteView: View {
    @Environment(\.modelContext) var modelContext
    @Query var tasks: [Note]
    
    init(searchString: String = "", sortOrder: [SortDescriptor<Note>] = []) {
        _tasks = Query(filter: #Predicate{ task in
            if searchString.isEmpty {
                true
            } else {
                task.title.localizedStandardContains(searchString) ||
                task.details.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }
    
    var body: some View {
        if tasks.isEmpty {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 16) {
                Image(.emptyState)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                
                Text("No notes found")
                    .font(.customStyle(type: .lexend, style: .semiBold, size: 18))

            }
            
        } else {
            List {
                ForEach(tasks) { task in
                    NavigationLink(value: task) {
                        HStack(spacing: 16) {
                            TaskImageView(imageData: task.photo)
                            
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .font(.customStyle(type: .lexend, style: .semiBold, size: 16))
                                    .listRowSeparator(.hidden)

                                Text(task.details)
                                    .font(.customStyle(type: .lexend, style: .light, size: 14))
                                    .listRowSeparator(.hidden)

                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .onDelete(perform: deleteTask)
                .listRowSeparator(.hidden)
            }

        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        for offset in offsets {
            let task = tasks[offset]
            modelContext.delete(task)
        }
    }
    
    private struct TaskImageView: View {
        let imageData: Data?
        var body: some View {
            if imageData != nil {
                let image = UIImage(data: imageData!)
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            } else {
                Image(uiImage: .emptyNote)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
            }
        }
    }
}

#Preview {
    do {
        let previwer = try Previwer()
        return NoteView()
            .modelContainer(previwer.container)
    }
    catch {
        return Text("Error to create preview: \(error.localizedDescription)")
    }
}
