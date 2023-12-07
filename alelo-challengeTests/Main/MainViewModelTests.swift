import XCTest
@testable import alelo_challenge

final class MainViewModelTests: XCTestCase {
    
    var sut: MainViewModel!

    override func setUpWithError() throws {
        let mockLoadService = JsonServiceMock()
        sut = MainViewModel(loadService: mockLoadService)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func test_load_data() {
        sut.loadData()
        
        XCTAssertFalse(sut.filteredProducts.isEmpty)
        XCTAssertNil(sut.error)
    }
    
    func test_add_product_to_cart() {
        sut.loadData()
        
        let productToAdd = sut.filteredProducts.first!
        sut.addProductToCart(product: productToAdd)
        
        XCTAssertEqual(sut.cart.count, 1)
        XCTAssertEqual(sut.cart.first?.productName, productToAdd.name)
        XCTAssertEqual(sut.cart.first?.amount, 1)
    }
    
    func test_add_existing_product_to_cart() {
        sut.loadData()
        
        let productToAdd = sut.filteredProducts.first!
        sut.addProductToCart(product: productToAdd)
        sut.addProductToCart(product: productToAdd)
        
        XCTAssertEqual(sut.cart.count, 1)
        XCTAssertEqual(sut.cart.first?.productName, productToAdd.name)
        XCTAssertEqual(sut.cart.first?.amount, 2)
    }
    
    func test_filter_products() {
        sut.loadData()
        XCTAssertEqual(sut.filteredProducts.count, 3)

        sut.filterSaleProducts()
        XCTAssertTrue(sut.isFiltered)
        XCTAssertTrue(sut.filteredProducts.allSatisfy { $0.on_sale })

        sut.filterSaleProducts()
        XCTAssertFalse(sut.isFiltered)
        XCTAssertEqual(sut.filteredProducts.count, 3)
    }
}
