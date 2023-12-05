import Foundation

protocol Viewcode {
    func configureSubViews()
    func configureConstraints()
}

extension Viewcode {
    func setupUI() {
        configureSubViews()
        configureConstraints()
    }
}
