import UIKit

struct TransferWireframeFlowModel {
    var sourceIban: String?
    var targetIban: String?
    var amount: Money?
}

class TransferWireframe: BaseWireframe {
    private let entryPoint: UINavigationController
    private let completionHandler: (() -> Void)?
    
    private var flowModel = TransferWireframeFlowModel()
    
    private var amountInputView : AmountInputView?
    private var summaryView : SummaryView?
    
    // MARK: - Flow
    
    init(entryPoint: UINavigationController, completionHandler: (() -> Void)?) {
        self.entryPoint = entryPoint
        self.completionHandler = completionHandler
    }
    
    func present() {
        presentAmount()
    }
    
    private func presentAmount() {
        amountInputView = AmountInputView()
        let presenter = AmountInputPresenter(
            view: amountInputView,
            nextHandler: { result in
                self.flowModel.amount = result
                self.pushSummary()
            }
        )
        
        amountInputView?.presenter = presenter
        
        present(entryPoint: entryPoint, viewController: amountInputView!)
    }
    
    private func pushSummary() {
        let transferModel = TransferModel(sourceIban: "DE12500105170648489890", targetIban: "DE12500105170648489890", amount: flowModel.amount!)
        
        let summaryView = SummaryView()
        let presenter = SummaryPresenter(
            view: summaryView,
            model: transferModel,
            nextHandler: nil
        )
        
        summaryView.presenter = presenter
        
        push(viewController: summaryView)
    }
}
