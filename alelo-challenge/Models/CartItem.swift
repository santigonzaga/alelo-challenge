import Foundation

struct CartItem {
    var productName: String
    var amount: Int
    var price: Double
}

extension CartItem {
    func totalPrice() -> String {
        let total = self.price * Double(self.amount)
        let formattedTotal = String(format: "%.2f", total)
        return "R$ \(formattedTotal)"
    }
}

extension Array where Element == CartItem {
    func calculateTotalPrice() -> String {
        let total = self.reduce(0) { $0 + $1.price * Double($1.amount) }
        let formattedTotal = String(format: "%.2f", total)
        return "Preço total: R$ \(formattedTotal)"
    }
}
