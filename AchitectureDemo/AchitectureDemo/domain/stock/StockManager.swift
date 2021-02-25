import RxSwift

class StockManager {
    func getStocks() -> Observable<[String]> {
        return Observable.just(["Daimler", "Apple", "Microsoft", "Volkswagen", "Coca Cola", "Tesla", "Amazon", "Paypal", "Alphabet", "Facebook", "Netflix"])
    }
}
