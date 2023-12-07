import XCTest
@testable import alelo_challenge

final class CartViewModelTests: XCTestCase {
    
    var sut: CartViewModel!

    override func setUpWithError() throws {
        sut = CartViewModel(cart: CartItem.getDummy())
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func test_delete_item() {
        XCTAssert(sut.cart.count == 3)
        sut.deleteItem(index: 2)
        XCTAssert(sut.cart.count == 2)
    }
}
