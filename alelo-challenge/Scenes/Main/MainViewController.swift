import UIKit

class MainViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    private var viewModel: MainViewModelProtocol
    
    init(viewModel: MainViewModelProtocol) {
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
        addNavigationButtons()
    }
    
    private lazy var productsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private func addNavigationButtons() {
        let cartImage = UIImage(systemName: "cart")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: cartImage,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(goToCart))
        
        let percentImage = UIImage(systemName: "percent")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: percentImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(filterSaleProducts))
    }
    
    @objc func goToCart() {
        coordinator?.goToCart(cart: viewModel.cart, actualViewController: self)
    }
    
    @objc func filterSaleProducts() {
        viewModel.filterSaleProducts()
        productsTableView.reloadData()
        
        let percentImageName = viewModel.isFiltered ? "arrow.uturn.backward" : "percent"
        let percentImage = UIImage(systemName: percentImageName)
        navigationItem.leftBarButtonItem?.image = percentImage
    }
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
        return viewModel.filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
        
        cell.configureCell(product: viewModel.filteredProducts[indexPath.row])
        cell.delegate = self
        
        return cell
    }
}

extension MainViewController: ProductTableViewCellDelegate {
    func addToCartButtonTapped(for cell: ProductTableViewCell) {
        if let indexPath = productsTableView.indexPath(for: cell) {
            viewModel.addProductToCart(product: viewModel.filteredProducts[indexPath.row])
        }
    }
}

extension MainViewController: CartViewControllerDelegate {
    func cartDidChange(cart: [CartItem]) {
        viewModel.cart = cart
        productsTableView.reloadData()
    }
}

