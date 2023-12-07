import Foundation
@testable import alelo_challenge

class CartViewModelMock: CartViewModelProtocol {
    var cart: [alelo_challenge.CartItem] = CartItem.getDummy()
    
    func deleteItem(index: Int) {}
}
