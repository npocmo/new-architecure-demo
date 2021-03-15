import UIKit

struct OrderWireframeFlowModel {
    var stockId: String?
}

class OrderWireframe: BaseWireframe {
    private let entryPoint: UINavigationController
    private let completionHandler: (() -> Void)?
    
    private var flowModel = OrderWireframeFlowModel()
    
    // MARK: - Flow
    
    init(entryPoint: UINavigationController, completionHandler: (() -> Void)?) {
        self.entryPoint = entryPoint
        self.completionHandler = completionHandler
    }
    
    func present() {
        presentSelectStock()
    }
    
    private func presentSelectStock() {
        let presenter = SelectStockPresenter(
            stockManager: StockManager(),
            balanceManager: BalanceManager(),
            depoManager: DepoManager(),
            nextHandler: { stockId in
                self.flowModel.stockId = stockId
                self.pushSelectStockAmount()
            }
        )
        let view = SelectStockView()
        view.presenter = presenter
        
        present(on: entryPoint, viewController: view, animated: true)
    }
    
    private func pushSelectStockAmount() {
        // To be continued...
        self.dismiss(animated: true)
    }
}
