//
//  ItemRow.swift
//  SimpleToDo
//
//  Created by Tomasz Ogrodowski on 08/05/2022.
//

import SwiftUI

struct ItemRow: View {
    @Binding var item: ToDoItem
    var body: some View {
        NavigationLink {
            DetailView(item: $item)
        } label: {
            Label(item.title, systemImage: item.icon)
                .animation(nil, value: item) // on iPad, on Two Windows Mode title animates when changed.
        }
        .tag(item)
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: .constant(.example))
    }
}
