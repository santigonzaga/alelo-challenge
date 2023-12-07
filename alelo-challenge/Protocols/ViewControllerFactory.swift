import UIKit

protocol ViewControllerFactory {
    func makeMainViewController() -> MainViewController
    func makeCartViewController(cart: [CartItem]) -> CartViewController
}

class DefaultViewControllerFactory: ViewControllerFactory {
    func makeMainViewController() -> MainViewController {
        return MainViewController(viewModel: MainViewModel(loadService: JsonService()))
    }

    func makeCartViewController(cart: [CartItem]) -> CartViewController {
        return CartViewController(viewModel: CartViewModel(cart: cart))
    }
}


