import Foundation
import RxSwift

protocol StockViewModelProtocol: StockViewModelProtocolInput, StockViewModelProtocolOutput {}

protocol StockViewModelProtocolInput {
    func viewDidLoad()
    func onRefreshButtonTouched()
    func onNextButtonTouched(stockId: String)
}

protocol StockViewModelProtocolOutput {
    var stocks: BehaviorSubject<[String]?> { get }
    var giroBalance: BehaviorSubject<String?> { get }
    var depoBalance: BehaviorSubject<String?> { get }
}

class SelectStockViewModel: StockViewModelProtocol {
    
    private let stockManager: StockManager
    private let balanceManager: BalanceManager
    private let depoManager: DepoManager
    private let nextHandler: ((String) -> Void)?
    
    // MARK: StockViewModelProtocolOutput
    
    // TODO: stocks should maybe be an enum with idle, loading and dataAvailable state
    var stocks = BehaviorSubject<[String]?>(value: nil)
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
        stocks.onNext(nil)
        
        stockManager.getStocks(
            completionHandler: { [weak self] result in
                switch result {
                case .success(let value):
                    self?.stocks.onNext(value)
                case .failure(let error):
                    self?.stocks.onError(error)
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
    
    // MARK: StockViewModelProtocolInput
    
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
