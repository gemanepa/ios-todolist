//
//  TodoListViewModel.swift
//  todo-list
//
//  Created by Gabriel Ernesto Martinez Canepa on 24/12/2023.
//

import SwiftUI
import Observation

@Observable class TodoListViewModel { // iOS < 17.0 --> class TodoListViewModel: ObservableObject {
    var todos = [TodoItem]() // iOS < 17.0 --> @Published var todos = [TodoItem]()
    var showAlert = false // iOS < 17.0 --> @Published var showAlert = false
    var alertMessage = "" // iOS < 17.0 --> @Published var alertMessage = ""

    // Function to add a new todo item
    func addTodo(newTodo: String) {
        print("Adding new todo: \(newTodo)")

        // Validate the new todo
        guard ValidationHelper.isValidTodo(newTodo, existingTodos: todos) else {
            showAlert = true
            alertMessage = "Invalid todo. Please check the requirements."
            return
        }
        print("Passed validations: \(newTodo)")

        // All checks passed, add the new todo
        let newTodo = TodoItem(title: newTodo)
        todos.append(newTodo)
    }

    // Function to reset alert properties
    func resetAlert() {
        showAlert = false
        alertMessage = ""
    }

    // Function to mark a todo item as completed
    func toggleTodoCompletion(_ todo: TodoItem) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].completed.toggle()
        }
    }

    // Function to delete a todo item by index
    func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            if index < todos.count {
                todos.remove(at: index)
            }
        }
    }

    // Other functions for CRUD operations, state management, etc.
}

