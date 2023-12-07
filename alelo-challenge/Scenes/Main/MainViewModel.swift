import Foundation

protocol MainViewModelProtocol {
    var products: [Product] { get set }
    var cart: [CartItem] { get set }
    
    func loadData()
    func addProductToCart(product: Product)
}

class MainViewModel: MainViewModelProtocol {
    var products: [Product] = []
    var cart: [CartItem] = []
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
    
    func addProductToCart(product: Product) {
        if let index = indexOfProduct(product: product) {
            cart[index].amount += 1
        } else {
            let cartItem = CartItem(productName: product.name,
                                    amount: 1,
                                    price: product.actual_price.convertToDouble())
            cart.append(cartItem)
        }
    }
    
    private func indexOfProduct(product: Product) -> Int? {
        return cart.firstIndex { $0.productName == product.name }
    }
}
