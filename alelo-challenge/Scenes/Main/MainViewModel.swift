import Foundation

protocol MainViewModelProtocol {
    func loadData()
}

class MainViewModel: MainViewModelProtocol {
    var products: [Product] = []
    var error: Error? = nil
    
    let loadService: LoadProductsProtocol
    
    init(loadService: LoadProductsProtocol) {
        self.loadService = loadService
    }
    
    func loadData() {
        do {
            products = try loadService.load()
        } catch {
            self.error = error
        }
    }
}
