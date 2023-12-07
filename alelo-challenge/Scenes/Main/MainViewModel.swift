import Foundation

protocol MainViewModelProtocol {
    var filteredProducts: [Product] { get set }
    var cart: [CartItem] { get set }
    var isFiltered: Bool { get set }
    
    func loadData()
    func addProductToCart(product: Product)
    func filterSaleProducts()
}

class MainViewModel: MainViewModelProtocol {
    private var products: [Product] = []
    var filteredProducts: [Product] = []
    var cart: [CartItem] = []
    var error: Error? = nil
    var isFiltered: Bool = false
    
    let loadService: LoadProductsProtocol
    
    init(loadService: LoadProductsProtocol) {
        self.loadService = loadService
    }
    
    func loadData() {
        do {
            products = try loadService.load()
            filteredProducts = products
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
    
    func filterSaleProducts() {
        isFiltered.toggle()
        
        if isFiltered {
            filteredProducts = products.filter { $0.on_sale }
        } else {
            filteredProducts = products
        }
    }
    
    private func indexOfProduct(product: Product) -> Int? {
        return cart.firstIndex { $0.productName == product.name }
    }
}
