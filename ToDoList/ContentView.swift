//
//  ContentView.swift
//  ToDoList
//
//  Created by Maurice Nowotni on 21.12.23.
//

import SwiftUI


struct ContentView: View {
    
    @State var str = "Hello, world!"
    @State var neueAufgabe = ""
    @State var tf_title = ""
    @State var tf_description = ""
    @FetchRequest(sortDescriptors: []) var toDoList: FetchedResults<ToDo>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationStack {
            VStack {
                List() {
                    ForEach(toDoList.indices, id: \.self) { i in
                        ListItems(b: i, toDoList1: toDoList)
                    }
                    .onDelete(perform: { indexSet in
                        deleteItems(at: indexSet)
                    })
                }
                
                
            }.navigationTitle(Text("Meine Aufgaben"))
                .toolbar {
                    //ToolbarItem(placement: .topBarLeading) {
                    //    Text("Edit")
                    //}
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(
                            destination: AddView(moc: _moc),
                            label: {
                                Text("Add")
                            }
                        )
                    }
                    
                    
                    
                    
                }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let itemToDelete = toDoList[index]
            moc.delete(itemToDelete)
        }
        try? moc.save()
    }
}

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var title = ""
    @State var description = ""
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Form {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
            }.padding()
        }.navigationTitle("Aufgabe hinzufügen")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        if !title.isEmpty && !description.isEmpty {
                            let toDo = ToDo(context: moc)
                            toDo.id = UUID()
                            toDo.title = title
                            toDo.info = description
                            toDo.isChecked = false
                            
                            try? moc.save()
                            
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
    }
}

struct ListItems: View {
    var b: Int
    var toDoList1: FetchedResults<ToDo>
    
    
    var body: some View {
        if b < toDoList1.count {
            HStack {
                VStack(alignment: .leading) {
                    Text(toDoList1[b].title ?? "Error").bold()
                    Text(toDoList1[b].info ?? "Error")
                }
                Spacer()
                Button(action: {
                    
                }, label: {
                    if toDoList1[b].isChecked {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "circle")
                    }
                })
            }
        }
    }
}


#Preview {
    ContentView()
}
