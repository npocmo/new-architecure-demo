import RxSwift

class StockManager {
    func getStocks() -> Observablee<[String]> {
        return Observablee(["Daimler", "Apple", "Microsoft", "Volkswagen", "Coca Cola", "Tesla", "Amazon", "Paypal", "Alphabet", "Facebook", "Netflix"])
    }
}
