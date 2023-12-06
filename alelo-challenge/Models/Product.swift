import Foundation

struct ProductResponse: Decodable {
    var products: [Product]
}

struct Product: Decodable {
    var name: String
    var style: String
    var code_color: String
    var color_slug: String
    var color: String
    var on_sale: Bool
    var regular_price: String
    var actual_price: String
    var discount_percentage: String
    var installments: String
    var image: String
    var sizes: [Size]
}

struct Size: Decodable {
    var available: Bool
    var size: String
    var sku: String
}
