import UIKit

class MainViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    private var viewModel: MainViewModel = MainViewModel(loadService: JsonService())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        
        viewModel.loadData()
    }


}

extension MainViewController: Viewcode {
    func configureSubViews() {
        <#code#>
    }
    
    func configureConstraints() {
        <#code#>
    }
}

