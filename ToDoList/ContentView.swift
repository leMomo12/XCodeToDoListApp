//
//  ContentView.swift
//  ToDoList
//
//  Created by Maurice Nowotni on 21.12.23.
//

import SwiftUI

struct ToDo: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var isChecked = false
}


struct ContentView: View {
    
    @State var str = "Hello, world!"
    @State var toDoList: [ToDo] = []
    @State var neueAufgabe = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List() {
                    ForEach(toDoList.indices, id: \.self) { i in
                        ListItems(b: i, toDoList1: $toDoList, toggleChecked: toggleChecked)
                    }
                    .onDelete(perform: { indexSet in
                        toDoList.remove(atOffsets: indexSet)
                    })
                }
                Spacer()
                HStack {
                    TextField("Neue Aufgabe", text: $neueAufgabe)
                    Button("Hinzufügen") {
                        let toDo = ToDo(title: neueAufgabe, description: "Hallo")
                        toDoList.append(toDo)
                        neueAufgabe = ""
                    }
                }
                .padding()
            }.navigationTitle(Text("Meine Aufgaben"))
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Edit")
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Text("Add")
                    }
                }
        }
    }
    
    func toggleChecked(index: Int) {
        toDoList[index].isChecked.toggle()
    }

}

struct ListItems: View {
    var b: Int
    @Binding var toDoList1: [ToDo]
    var toggleChecked: (Int) -> Void

    var body: some View {
        if b < toDoList1.count {
            HStack {
                VStack(alignment: .leading) {
                    Text(toDoList1[b].title).bold()
                    Text(toDoList1[b].description)
                }
                Spacer()
                Button(action: {
                    toggleChecked(b)
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
