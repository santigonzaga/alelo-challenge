import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let viewControllerFactory: ViewControllerFactory

    init(navigationController: UINavigationController,
         viewControllerFactory: ViewControllerFactory = DefaultViewControllerFactory()) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }

    func start() {
        let vc = viewControllerFactory.makeMainViewController()
        vc.coordinator = self
        pushViewController(vc, animated: false)
    }
    
    func goToCart(cart: [CartItem], actualViewController: CartViewControllerDelegate) {
        let vc = viewControllerFactory.makeCartViewController(cart: cart)
        vc.coordinator = self
        vc.delegate = actualViewController
        presentViewController(vc, animated: true)
    }
    
    func dismissCart() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    private func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }

    private func presentViewController(_ viewController: UIViewController, animated: Bool) {
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController.present(navigationController, animated: animated, completion: nil)
    }
}
