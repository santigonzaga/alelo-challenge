import Foundation

protocol MainViewModelProtocol {
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
        
        print(cart)
    }
    
    private func indexOfProduct(product: Product) -> Int? {
        return cart.firstIndex { $0.productName == product.name }
    }
}

extension String {
    func convertToDouble() -> Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US") // Set the locale to handle the currency format
        
        // Remove non-numeric characters and convert to a double
        if let number = formatter.number(from: self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)) {
            return Double(truncating: number)
        }
        
        return 0.0
    }
}
