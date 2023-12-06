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
        
        viewModel.loadData()
        
        productsTableView.dataSource = self
        
        setupUI()
    }
    
    private lazy var productsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
}

extension MainViewController: Viewcode {
    func configureSubViews() {
        view.addSubview(productsTableView)
    }
    
    func configureConstraints() {
        let productsTableViewConstraints = [
            productsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            productsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            productsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            productsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ]
        
        NSLayoutConstraint.activate(productsTableViewConstraints)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
        
        cell.configureCell(product: viewModel.products[indexPath.row])
        cell.delegate = self
        
        return cell
    }
}

extension MainViewController: ProductTableViewCellDelegate {
    func addToCartButtonTapped(for cell: ProductTableViewCell) {
        if let indexPath = productsTableView.indexPath(for: cell) {
            viewModel.addProductToCart(product: viewModel.products[indexPath.row])
        }
    }
}

