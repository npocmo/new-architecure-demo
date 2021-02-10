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
    
    // MARK: - Flow
    
    init(entryPoint: UINavigationController, completionHandler: (() -> Void)?) {
        self.entryPoint = entryPoint
        self.completionHandler = completionHandler
    }
    
    func present() {
        presentAmount()
    }
    
    private func presentAmount() {
        let view = AmountInputView()
        let interactor = AmountInputInteractor()
        let presenter = AmountInputPresenter(
            view: view,
            interactor: interactor,
            nextHandler: { result in
                self.flowModel.amount = result
                self.pushSummary()
            }
        )
        
        view.presenter = presenter
        
        present(on: entryPoint, viewController: view, animated: true)
    }
    
    private func pushSummary() {
        let transferModel = TransferModel(sourceIban: "DE12500105170648489890", targetIban: "DE12500105170648489890", amount: flowModel.amount!)
        
        let summaryView = SummaryView()
        let presenter = SummaryPresenter(
            view: summaryView,
            model: transferModel,
            nextHandler: {
                //self.pop(animated: true)
            }
        )
        
        summaryView.presenter = presenter
        
        push(viewController: summaryView, animated: true)
    }
}
