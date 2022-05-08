//
//  ContentView.swift
//  SimpleToDo
//
//  Created by Tomasz Ogrodowski on 08/05/2022.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var model: ViewModel

    @State private var selectedItems = Set<ToDoItem>()
    @State private var editMode = EditMode.inactive

    var body: some View {
        List(selection: $selectedItems) {
            ForEach($model.items) { $item in
                ItemRow(item: $item)
            }
            .onDelete(perform: model.delete)
        }
        .navigationTitle("SimpleToDo")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading, content: EditButton.init)

            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    model.add()
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }

            ToolbarItem(placement: .bottomBar) {
                if editMode == .active {
                    HStack {
                        Spacer()
                        Button(role: .destructive) {
                            model.delete(selectedItems)
                            selectedItems.removeAll()
                        } label: {
                            Label("Delete selected", systemImage: "trash")
                        }
                        .disabled(selectedItems.isEmpty)
                    }
                }
            }
        }
        .animation(.default, value: model.items) // animates whenever array change
        .listStyle(.sidebar)
        .environment(\.editMode, $editMode)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: ViewModel())
    }
}
