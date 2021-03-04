import Foundation
import RxSwift
import RxDataSources

protocol SelectStockViewModelProtocol: SelectStockViewModelProtocolInput, SelectStockViewModelProtocolOutput {}

protocol SelectStockViewModelProtocolInput {
    func viewDidLoad()
    func onRefreshButtonTouched()
    func onNextButtonTouched(stockId: String?)
}

protocol SelectStockViewModelProtocolOutput {
    var stocks: BehaviorSubject<[SelectStockTableCellModel]?> { get }
    var giroBalance: BehaviorSubject<String?> { get }
    var depoBalance: BehaviorSubject<String?> { get }
}

enum SelectStockTableCellModel {
    case idle
    case loading
    case empty
    case error(error: Error)
    case dataAvailable(stock: String)
}

class SelectStockViewModel: SelectStockViewModelProtocol {
    
    private let stockManager: StockManager
    private let balanceManager: BalanceManager
    private let depoManager: DepoManager
    private let nextHandler: ((String) -> Void)?
    
    // MARK: SelectStockViewModelProtocolOutput
    
    var stocks = BehaviorSubject<[SelectStockTableCellModel]?>(value: nil)
    var giroBalance = BehaviorSubject<String?>(value: nil)
    var depoBalance = BehaviorSubject<String?>(value: nil)
    
    // MARK: Init
    
    init(stockManager: StockManager, balanceManager: BalanceManager, depoManager: DepoManager, nextHandler: ((String) -> Void)?) {
        self.stockManager = stockManager
        self.balanceManager = balanceManager
        self.depoManager = depoManager
        self.nextHandler = nextHandler
    }
    
    // MARK: Managers
    
    func fetchStocks() {
        stocks.onNext([SelectStockTableCellModel.loading])
        
        stockManager.getStocks(
            completionHandler: { [weak self] result in
                self?.createStocksModel(result)
            }
        )
    }
    
    private func createStocksModel(_ result: Result<[String], Error>) {
        switch result {
        case .success(let value):
            if value.isEmpty {
                stocks.onNext([SelectStockTableCellModel.empty])
                return
            }
            
            stocks.onNext(createStocksDataAvailableArray(value))
        case .failure(let error):
            stocks.onNext([SelectStockTableCellModel.error(error: error)])
        }
    }
    
    private func createStocksDataAvailableArray(_ stocks: [String]) -> [SelectStockTableCellModel] {
        var result = [SelectStockTableCellModel]()
        for stock in stocks {
            result.append(SelectStockTableCellModel.dataAvailable(stock: stock))
        }
        return result
    }
    
    func fetchDepoBalance() {
        depoManager.getDepoBalance(
            completionHandler: { [weak self] result in
                switch result {
                case .success(let value):
                    let depoBalanceString = self?.toBalanceString(value)
                    self?.depoBalance.onNext(depoBalanceString)
                case .failure(let error):
                    self?.depoBalance.onError(error)
                }
            }
        )
    }
    
    func fetchGiroBalance() {
        balanceManager.getGiroBalance(
            completionHandler: { [weak self] result in
                switch result {
                case .success(let value):
                    let giroBalanceString = self?.toBalanceString(value)
                    self?.giroBalance.onNext(giroBalanceString)
                case .failure(let error):
                    self?.giroBalance.onError(error)
                }
            }
        )
    }
    
    // MARK: SelectStockViewModelProtocolInput
    
    func viewDidLoad() {
        fetchStocks()
        fetchDepoBalance()
        fetchGiroBalance()
    }
    
    func onRefreshButtonTouched() {
        fetchStocks()
    }
    
    func onNextButtonTouched(stockId: String?) {
        guard let stockId = stockId else { return }
        nextHandler?(stockId)
    }
    
    // MARK: Mapping
    
    private func toBalanceString(_ balance: Balance) -> String {
        return String(balance.amount.value.description) + " " + String(balance.amount.currency.iso)
    }
}
