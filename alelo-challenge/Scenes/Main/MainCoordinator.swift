import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = MainViewController(viewModel: MainViewModel(loadService: JsonService()))
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToCart(cart: [CartItem]) {
        let vc = CartViewController(viewModel: CartViewModel(cart: cart))
        vc.coordinator = self
        let navigationController = UINavigationController(rootViewController: vc)
        self.navigationController.present(navigationController, animated: true, completion: nil)
    }
}
