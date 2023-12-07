import Foundation

protocol CartViewModelProtocol {
    var cart: [CartItem] { get set }
    
    func deleteItem(index: Int)
}

class CartViewModel: CartViewModelProtocol {
    var cart: [CartItem]
    
    init(cart: [CartItem]) {
        self.cart = cart
    }
    
    func deleteItem(index: Int) {
        cart.remove(at: index)
    }
}

