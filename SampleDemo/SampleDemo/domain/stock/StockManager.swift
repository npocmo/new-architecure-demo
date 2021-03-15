import RxSwift
import Foundation

class StockManager {
    func getStocks(completionHandler: @escaping (Result<[String], Error>) -> Void) {
        let stocks = ["Daimler", "Apple", "Microsoft", "Volkswagen", "Coca Cola", "Tesla", "Amazon", "Paypal", "Alphabet", "Facebook", "Netflix"].sorted { $0 < $1 }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler(.success(stocks))
        }
    }
}
