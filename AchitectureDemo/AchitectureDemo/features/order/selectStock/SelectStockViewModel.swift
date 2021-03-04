import Foundation
import RxSwift
import RxDataSources

protocol SelectStockViewModelProtocol: SelectStockViewModelProtocolInput, SelectStockViewModelProtocolOutput {}

protocol SelectStockViewModelProtocolInput {
    func viewDidLoad()
    func onRefreshButtonTouched()
    func onNextButtonTouched(stockId: String)
}

protocol SelectStockViewModelProtocolOutput {
    var stocks: BehaviorSubject<SelectStockTableModel> { get }
    var giroBalance: BehaviorSubject<String?> { get }
    var depoBalance: BehaviorSubject<String?> { get }
}

enum SelectStockTableModel {
    case idle
    case loading
    case empty
    case error(error: Error)
    case dataAvailable(stocks: [String])
}

class SelectStockViewModel: SelectStockViewModelProtocol {
    
    private let stockManager: StockManager
    private let balanceManager: BalanceManager
    private let depoManager: DepoManager
    private let nextHandler: ((String) -> Void)?
    
    // MARK: SelectStockViewModelProtocolOutput
    
    // TODO: stocks should maybe be an enum with idle, loading and dataAvailable state
    var stocks = BehaviorSubject<SelectStockTableModel>(value: SelectStockTableModel.idle)
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
        // loading state
        stocks.onNext(SelectStockTableModel.loading)
        
        stockManager.getStocks(
            completionHandler: { [weak self] result in
                switch result {
                case .success(let value):
                    if value.isEmpty {
                        self?.stocks.onNext(SelectStockTableModel.empty)
                        return
                    }
                    
                    self?.stocks.onNext(SelectStockTableModel.dataAvailable(stocks: value))
                case .failure(let error):
                    self?.stocks.onNext(SelectStockTableModel.error(error: error))
                }
            }
        )
    }
    
    func fetchDepoBalance() {
        depoManager.getDepoBalance(
            completionHandler: { [weak self] result in
                switch result {
                case .success(let value):
                    let depoBalanceString = self?.mapBalanceToString(value)
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
                    let giroBalanceString = self?.mapBalanceToString(value)
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
    
    func onNextButtonTouched(stockId: String) {
        nextHandler?(stockId)
    }
    
    // MARK: Mapping
    
    private func mapBalanceToString(_ balance: Balance) -> String {
        return String(balance.amount.value.description) + " " + String(balance.amount.currency.iso)
    }
    
    // MARK: Error Handling
    
    private func handle(_ error: Error) {
        print(error)
    }
}
