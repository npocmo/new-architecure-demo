import Foundation
import RxSwift

protocol StockViewModelProtocol {
    func viewDidLoad()
    func onRefreshButtonTouched()
    func onNextButtonTouched(stockId: String)
}

class SelectStockViewModel: StockViewModelProtocol {
    private let stockManager: StockManager
    private let nextHandler: ((String) -> Void)?
    
    var stocks = BehaviorSubject<[String]>(value: [""])
    
    init(stockManager: StockManager, nextHandler: ((String) -> Void)?) {
        self.stockManager = stockManager
        self.nextHandler = nextHandler
    }
    
    // MARK: Get Domain Model
    
    func fetchStocks() {
        stockManager.getStocks(
            completionHandler: { result in
                switch result {
                case .success(let value):
                    self.stocks.onNext(value)
                case .failure(let error):
                    self.handle(error)
                }
            }
        )
    }
    
    // MARK: StockViewModelProtocol
    
    func viewDidLoad() {
        fetchStocks()
    }
    
    func onRefreshButtonTouched() {
        fetchStocks()
    }
    
    func onNextButtonTouched(stockId: String) {
        nextHandler?(stockId)
    }
    
    // MARK: Error Handling
    
    private func handle(_ error: Error) {
        print(error)
    }
}
