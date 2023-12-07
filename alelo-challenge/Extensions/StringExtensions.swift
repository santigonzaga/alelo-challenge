import Foundation

extension String {
    func convertToDouble() -> Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        
        if let number = formatter.number(from: self.replacingOccurrences(of: "[^0-9,]", with: "", options: .regularExpression)) {
            return Double(truncating: number)
        }
        
        return 0.0
    }
}
