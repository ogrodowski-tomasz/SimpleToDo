//
//  ViewModel.swift
//  SimpleToDo
//
//  Created by Tomasz Ogrodowski on 08/05/2022.
//

import Combine
import Foundation

class ViewModel: ObservableObject {
    @Published var items: [ToDoItem]

    private let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedItems")

    private var saveSubscription: AnyCancellable?

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            items = try JSONDecoder().decode([ToDoItem].self, from: data)
        } catch let error {
            items = []
            print("Error decoding data: \(error.localizedDescription)")
        }

        addSubscribers()
    }

    func addSubscribers() {
        saveSubscription = $items
            .debounce(for: 5, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.save()
            }
    }

    func save() {
        print("Saving!")
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch let error {
            print("Unable to save data: \(error.localizedDescription)")
        }
    }

    func add() {
        let newItem = ToDoItem()
        items.append(newItem)
    }

    // swipe to delete
    func delete(_ offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    /// We want to let user mark a couple of ToDoItems to delete them all at once 
    func delete(_ selected: Set<ToDoItem>) {
        items.removeAll(where: selected.contains) // Remove items from array if they're also in the set
    }
}
