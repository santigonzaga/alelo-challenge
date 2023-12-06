@testable import alelo_challenge

class MainViewModelMock: MainViewModelProtocol {
    var products: [alelo_challenge.Product] = []
    
    init() {
        products = [product1, product2, product3]
    }
    
    func loadData() {}
    
    func addProductToCart(product: alelo_challenge.Product) {}
    
    let product1 = Product(
                name: "VESTIDO TRANSPASSE BOW",
                style: "20002605",
                code_color: "20002605_613",
                color_slug: "tapecaria",
                color: "TAPEÇARIA",
                on_sale: false,
                regular_price: "R$ 199,90",
                actual_price: "R$ 199,90",
                discount_percentage: "",
                installments: "3x R$ 66,63",
                image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912",
                sizes: [
                    Size(available: false, size: "PP", sku: "5807_343_0_PP"),
                    Size(available: true, size: "P", sku: "5807_343_0_P"),
                    Size(available: true, size: "M", sku: "5807_343_0_M"),
                    Size(available: true, size: "G", sku: "5807_343_0_G"),
                    Size(available: false, size: "GG", sku: "5807_343_0_GG")
                ]
            )

    let product2 = Product(
        name: "REGATA ALCINHA FOLK",
        style: "20002570",
        code_color: "20002570_614",
        color_slug: "preto",
        color: "PRETO",
        on_sale: false,
        regular_price: "R$ 99,90",
        actual_price: "R$ 99,90",
        discount_percentage: "",
        installments: "3x R$ 33,30",
        image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002570_002_catalog_1.jpg?1459948578",
        sizes: [
            Size(available: true, size: "PP", sku: "5723_40130843_0_PP"),
            Size(available: true, size: "P", sku: "5723_40130843_0_P"),
            Size(available: true, size: "M", sku: "5723_40130843_0_M"),
            Size(available: true, size: "G", sku: "5723_40130843_0_G"),
            Size(available: true, size: "GG", sku: "5723_40130843_0_GG")
        ]
    )

    let product3 = Product(
        name: "TOP CROPPED SUEDE",
        style: "20002575",
        code_color: "20002575_035",
        color_slug: "caramelo",
        color: "CARAMELO",
        on_sale: false,
        regular_price: "R$ 129,90",
        actual_price: "R$ 129,90",
        discount_percentage: "",
        installments: "3x R$ 43,30",
        image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002575_027_catalog_1.jpg?1459537946",
        sizes: [
            Size(available: false, size: "PP", sku: "5733_1000054_0_PP"),
            Size(available: true, size: "P", sku: "5733_1000054_0_P"),
            Size(available: true, size: "M", sku: "5733_1000054_0_M"),
            Size(available: true, size: "G", sku: "5733_1000054_0_G"),
            Size(available: false, size: "GG", sku: "5733_1000054_0_GG")
        ]
    )
}
