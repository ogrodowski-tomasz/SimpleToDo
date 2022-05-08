//
//  DetailView.swift
//  SimpleToDo
//
//  Created by Tomasz Ogrodowski on 08/05/2022.
//

import SwiftUI

struct DetailView: View {

    @Binding var item: ToDoItem

    var body: some View {
        Form {
            Section {
                TextField("Title", text: $item.title)

                Picker("Priority", selection: $item.priority) {
                    ForEach(ToDoItem.Priority.allCases, id: \.self) { priority in
                        Text(priority.rawValue)
                            .tag(priority)
                    }
                }
                .pickerStyle(.segmented)
            }

            Section {
                Toggle("Mark Completed", isOn: $item.isComplete)
            }
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(item: .constant(.example))
    }
}
