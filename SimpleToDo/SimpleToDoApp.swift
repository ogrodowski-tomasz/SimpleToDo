//
//  SimpleToDoApp.swift
//  SimpleToDo
//
//  Created by Tomasz Ogrodowski on 08/05/2022.
//

import SwiftUI

@main
struct SimpleToDoApp: App {
    // Make it (viewmodel) once, keep it alive, share it in all app instances
    @StateObject private var model = ViewModel()

    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(model: model)
                SelectSomethingView()
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                model.save()
            }
        }
    }
}
