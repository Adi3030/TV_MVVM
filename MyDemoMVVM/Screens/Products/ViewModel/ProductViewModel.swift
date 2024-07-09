//
//  ProductViewModel.swift
//  MyDemoMVVM
//
//  Created by aditya sharma on 18/06/24.
//

import Foundation

final class ProductViewModel {
    
    var product : [Product] = []
    var eventHandler: ((_ event: Event) -> Void)? // data binding clouser
    
    func fetchProducts(){
        eventHandler?(.loading)
        APIManager.shared.fetchProducts { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                self.product = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventHandler?(.error(error))
            }
        }
    }
}
extension ProductViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
