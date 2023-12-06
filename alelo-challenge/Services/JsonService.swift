import Foundation

enum JsonError: Error {
    case jsonNotFound, decodingFailed
}

protocol LoadProductsProtocol {
    func load() throws -> [Product]
}

class JsonService: LoadProductsProtocol {
    let bundle: Bundle
    let jsonDecoder: JSONDecoder
    let jsonName: String
    
    init(jsonName: String = "alelo",
         bundle: Bundle = .main,
         jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.bundle = bundle
        self.jsonDecoder = jsonDecoder
        self.jsonName = jsonName
    }
    
    func load() throws -> [Product] {
        guard let url = bundle.url(forResource: jsonName, withExtension: "json") else {
            throw JsonError.jsonNotFound
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
            let decodedData = try jsonDecoder.decode(ProductResponse.self, from: jsonData)
            return decodedData.products
        } catch {
            throw JsonError.decodingFailed
        }
    }
}
