import RxSwift

protocol StockViewModelProtocol {
    func viewDidLoad()
    func reload()
    func onNextButtonTouched(stockId: String)
}

class SelectStockViewModel: StockViewModelProtocol {
    private let stockManager: StockManager
    private let nextHandler: ((String) -> Void)?
    
    var stocks: Observable<[String]> = Observable.just([])
    
    init(stockManager: StockManager, nextHandler: ((String) -> Void)?) {
        self.stockManager = stockManager
        self.nextHandler = nextHandler
    }
    
    // MARK: StockViewModelProtocol
    
    func viewDidLoad() {
        stocks = stockManager.getStocks()
    }
    
    func reload() {
        stocks = stockManager.getStocks()
    }
    
    func onNextButtonTouched(stockId: String) {
        nextHandler?(stockId)
    }
}
