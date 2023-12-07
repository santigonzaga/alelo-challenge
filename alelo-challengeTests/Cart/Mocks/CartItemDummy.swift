import Foundation
@testable import alelo_challenge

extension CartItem {
    static func getDummy() -> [CartItem] {
        let cartItem1 = CartItem(productName: "Short", amount: 2, price: 69.90)
        let cartItem2 = CartItem(productName: "Bermuda", amount: 1, price: 159.90)
        let cartItem3 = CartItem(productName: "Camiseta", amount: 4, price: 39.90)
        
        return [cartItem1, cartItem2, cartItem3]
    }
}
