import UIKit

class MainViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    private var viewModel: MainViewModel = MainViewModel(loadService: JsonService())
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        
        viewModel.loadData()
    }


}

//extension MainViewController: Viewcode {
//    func configureSubViews() {
//        <#code#>
//    }
//    
//    func configureConstraints() {
//        <#code#>
//    }
//}

