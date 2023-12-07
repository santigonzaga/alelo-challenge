import XCTest
import SnapshotTesting
@testable import alelo_challenge

class CartViewControllerTests: XCTestCase {
    var sut: CartViewController!
    
    override func setUpWithError() throws {
        let viewModel = CartViewModelMock()
        sut = CartViewController(viewModel: viewModel)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_snapshot() {
        assertSnapshot(of: sut, as: .image, record: false)
    }
}
