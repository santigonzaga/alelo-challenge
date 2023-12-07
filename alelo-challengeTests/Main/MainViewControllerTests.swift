import XCTest
import SnapshotTesting
@testable import alelo_challenge

class MainViewControllerTests: XCTestCase {
    var sut: MainViewController!
    
    override func setUpWithError() throws {
        let viewModel = MainViewModelMock()
        sut = MainViewController(viewModel: viewModel)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_snapshot() {
        assertSnapshot(of: sut, as: .image, record: false)
    }
}

