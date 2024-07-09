//
//  ViewController.swift
//  MyDemoMVVM
//
//  Created by aditya sharma on 31/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModel = TodoViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Todo", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "To-Do List"
        
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        setupTableView()
        setupAddButton()
        
        viewModel.todosDidChange = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    private func setupAddButton() {
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func didTapAddButton() {
        let alert = UIAlertController(title: "New Todo", message: "Enter new todo item", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Todo title"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let title = alert.textFields?.first?.text, !title.isEmpty {
                self?.viewModel.addTodo(title: title)
            }
        }
        alert.addAction(addAction)
        present(alert, animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let todo = viewModel.todos[indexPath.row]
        cell.textLabel?.text = todo.title
        cell.accessoryType = todo.isCompleted ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = viewModel.todos[indexPath.row]
        viewModel.toggleCompletion(for: todo)
    }
}

