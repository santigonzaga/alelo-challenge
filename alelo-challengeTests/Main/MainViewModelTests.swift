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
        
        XCTAssertFalse(sut.products.isEmpty)
        XCTAssertNil(sut.error)
    }
    
    func test_add_product_to_cart() {
        sut.loadData()
        
        let productToAdd = sut.products.first!
        sut.addProductToCart(product: productToAdd)
        
        XCTAssertEqual(sut.cart.count, 1)
        XCTAssertEqual(sut.cart.first?.productName, productToAdd.name)
        XCTAssertEqual(sut.cart.first?.amount, 1)
    }
    
    func testAddExistingProductToCart() {
        sut.loadData()
        
        let productToAdd = sut.products.first!
        sut.addProductToCart(product: productToAdd)
        sut.addProductToCart(product: productToAdd)
        
        XCTAssertEqual(sut.cart.count, 1)
        XCTAssertEqual(sut.cart.first?.productName, productToAdd.name)
        XCTAssertEqual(sut.cart.first?.amount, 2)
    }
}
