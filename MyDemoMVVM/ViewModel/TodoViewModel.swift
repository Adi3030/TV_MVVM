//
//  TodoViewModel.swift
//  MyDemoMVVM
//
//  Created by aditya sharma on 31/05/24.
//

import Foundation

class TodoViewModel {
    private(set) var todos: [TodoItem] = []
    
    var todosDidChange: (() -> Void)?
    
    init() {
        fetchTodos()
    }
    
    func fetchTodos() {
        // Simulating network or database fetch
        self.todos = [
            TodoItem(id: UUID(), title: "Buy groceries", isCompleted: false),
            TodoItem(id: UUID(), title: "Walk the dog", isCompleted: true),
            TodoItem(id: UUID(), title: "Read a book", isCompleted: false)
        ]
        todosDidChange?()
    }
    
    func addTodo(title: String) {
        let newTodo = TodoItem(id: UUID(), title: title, isCompleted: false)
        todos.append(newTodo)
        todosDidChange?()
    }
    
    func toggleCompletion(for todo: TodoItem) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isCompleted.toggle()
            todosDidChange?()
        }
    }
}
