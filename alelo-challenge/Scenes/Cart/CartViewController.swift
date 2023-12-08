import UIKit

protocol CartViewControllerDelegate: AnyObject {
    func cartDidChange(cart: [CartItem])
}

class CartViewController: UIViewController {
    
    //MARK: - Properties
    weak var coordinator: MainCoordinator?
    weak var delegate: CartViewControllerDelegate?
    private var viewModel: CartViewModelProtocol
    
    //MARK: - Init
    init(viewModel: CartViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTableView.dataSource = self
        
        setupUI()
        addNavigationButtons()
        priceLabel.text = viewModel.cart.calculateTotalPrice()
        view.backgroundColor = .white
    }
    
    //MARK: - Properties UI
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var cartTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartItemTableViewCell.self, forCellReuseIdentifier: CartItemTableViewCell.identifier)
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private func addNavigationButtons() {
        let close = UIImage(systemName: "xmark")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: close, style: .done, target: self, action: #selector(dismissCart))
    }
    
    //MARK: - Actions
    @objc func dismissCart() {
        coordinator?.dismissCart()
    }
}

extension CartViewController: Viewcode {
    func configureSubViews() {
        view.addSubview(priceLabel)
        view.addSubview(cartTableView)
    }
    
    func configureConstraints() {
        let priceLabelConstraints = [
            priceLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ]

        let productsTableViewConstraints = [
            cartTableView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            cartTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            cartTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            cartTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ]
        
        NSLayoutConstraint.activate(priceLabelConstraints)
        NSLayoutConstraint.activate(productsTableViewConstraints)
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemTableViewCell.identifier, for: indexPath) as! CartItemTableViewCell
        
        cell.configureCell(cartItem: viewModel.cart[indexPath.row])
        cell.delegate = self
        
        return cell
    }
}

extension CartViewController: CartItemTableViewCellDelegate {
    func stepperButtonTapped(for cell: CartItemTableViewCell, newValue: Int) {
        if let indexPath = cartTableView.indexPath(for: cell) {
            viewModel.cart[indexPath.row].amount = newValue
            cartTableView.reloadRows(at: [indexPath], with: .automatic)
            priceLabel.text = viewModel.cart.calculateTotalPrice()
            delegate?.cartDidChange(cart: viewModel.cart)
        }
    }
    
    func deleteButtonTapped(for cell: CartItemTableViewCell) {
        if let indexPath = cartTableView.indexPath(for: cell) {
            viewModel.deleteItem(index: indexPath.row)
            priceLabel.text = viewModel.cart.calculateTotalPrice()
            cartTableView.reloadData()
            delegate?.cartDidChange(cart: viewModel.cart)
        }
    }
}


