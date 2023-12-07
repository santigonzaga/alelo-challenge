import UIKit

protocol CartItemTableViewCellDelegate: AnyObject {
    func stepperButtonTapped(for cell: CartItemTableViewCell, newValue: Int)
}

class CartItemTableViewCell: UITableViewCell {
    
    static let identifier = "CartItemTableViewCell"
    weak var delegate: CartItemTableViewCellDelegate?

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 3
        
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var amountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var amountStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.addTarget(self, action: #selector(stepperButtonPressed), for: .valueChanged)
        
        return stepper
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    @objc func stepperButtonPressed() {
        delegate?.stepperButtonTapped(for: self, newValue: Int(amountStepper.value))
    }
    
    func configureCell(cartItem: CartItem) {
        nameLabel.text = cartItem.productName
        priceLabel.text = cartItem.totalPrice()
        amountLabel.text = "\(cartItem.amount)"
        amountStepper.value = Double(cartItem.amount)
        
        configureSubViews()
        configureConstraints()
    }
    
    func configureSubViews() {
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(priceLabel)
        mainStackView.addArrangedSubview(amountStackView)
        amountStackView.addArrangedSubview(amountStepper)
        amountStackView.addArrangedSubview(amountLabel)
    }
    
    func configureConstraints() {
        let mainStackViewConstraints = [
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(mainStackViewConstraints)
    }
}

