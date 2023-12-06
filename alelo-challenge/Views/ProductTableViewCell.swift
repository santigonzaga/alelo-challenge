import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {
    
    static let identifier = "ProductTableViewCell"

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
    
    private lazy var newPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var oldPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var discountPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.font = .systemFont(ofSize: 22)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var sizePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        return pickerView
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Adicionar no carrinho", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        return button
    }()
    
    func configureCell(product: Product) {
        let url = URL(string: product.image)
        productImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        
        nameLabel.text = product.name
        newPriceLabel.text = product.actual_price
        
        if product.on_sale {
            oldPriceLabel.text = product.regular_price
            discountPriceLabel.text = product.discount_percentage
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
        labelStackView.addArrangedSubview(oldPriceLabel)
        labelStackView.addArrangedSubview(discountPriceLabel)
        //buttonStackView.addArrangedSubview(sizePickerView)
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
            productImageView.heightAnchor.constraint(equalToConstant: 60),
            productImageView.widthAnchor.constraint(equalToConstant: 60),
        ]
        
        NSLayoutConstraint.activate(mainStackViewConstraints)
        NSLayoutConstraint.activate(productImageViewConstraints)
    }

}
