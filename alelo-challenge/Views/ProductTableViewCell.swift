import UIKit
import Kingfisher

protocol ProductTableViewCellDelegate: AnyObject {
    func addToCartButtonTapped(for cell: ProductTableViewCell)
}

class ProductTableViewCell: UITableViewCell {
    
    static let identifier = "ProductTableViewCell"
    weak var delegate: ProductTableViewCellDelegate?

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
    
    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
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
    
    private lazy var newPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var discountPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.font = .systemFont(ofSize: 20)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var sizeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        
        return segmentedControl
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Carrinho", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(addToCartButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func addToCartButtonPressed() {
        delegate?.addToCartButtonTapped(for: self)
    }
    
    func configureCell(product: Product) {
        let url = URL(string: product.image)
        productImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        
        nameLabel.text = product.name

        if product.on_sale {
            newPriceLabel.text = "\(product.actual_price) (era \(product.regular_price))"
            discountPriceLabel.text = product.discount_percentage
        } else {
            newPriceLabel.text = "\(product.actual_price)"
            discountPriceLabel.text = ""
        }
        
        sizeSegmentedControl.removeAllSegments()
        
        for (index, size) in product.sizes.enumerated() {
            sizeSegmentedControl.insertSegment(withTitle: size.size, at: index, animated: false)
            sizeSegmentedControl.setEnabled(size.available, forSegmentAt: index)
        }
        
        configureSubViews()
        configureConstraints()
    }
    
    func configureSubViews() {
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(imageStackView)
        mainStackView.addArrangedSubview(buttonStackView)
        imageStackView.addArrangedSubview(productImageView)
        imageStackView.addArrangedSubview(labelStackView)
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(newPriceLabel)
        labelStackView.addArrangedSubview(discountPriceLabel)
        buttonStackView.addArrangedSubview(sizeSegmentedControl)
        buttonStackView.addArrangedSubview(addToCartButton)
    }
    
    func configureConstraints() {
        let mainStackViewConstraints = [
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        let productImageViewConstraints = [
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
        ]
        
        NSLayoutConstraint.activate(mainStackViewConstraints)
        NSLayoutConstraint.activate(productImageViewConstraints)
    }

}
