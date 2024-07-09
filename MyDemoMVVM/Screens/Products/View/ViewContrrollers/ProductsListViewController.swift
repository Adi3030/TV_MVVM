//
//  ProductsListViewController.swift
//  MyDemoMVVM
//
//  Created by aditya sharma on 18/06/24.
//

import UIKit

class ProductsListViewController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    private var viewModel = ProductViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        // Do any additional setup after loading the view.
    }
    


}
extension ProductsListViewController {
    
    func configuration() {
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
         initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchProducts()
    }
    // data binding event observe
    func observeEvent() {
        viewModel.eventHandler = { [weak self ] event in
            guard let self else { return }
            
            switch event {
            case .loading: break;
            case .stopLoading: break;
            case .dataLoaded:
                print(self.viewModel.product)
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}
extension ProductsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.product.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = viewModel.product[indexPath.row ]
        cell.product = product
        return cell
    }
}
