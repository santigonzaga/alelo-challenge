import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        // TODO: improve this
        let vc = MainViewController(viewModel: MainViewModel(loadService: JsonService()))
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
