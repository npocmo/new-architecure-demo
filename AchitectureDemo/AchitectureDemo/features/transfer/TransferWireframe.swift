import UIKit

struct TransferWireframeFlowModel {
    var sourceIban: String?
    var targetIban: String?
    var amount: Money?
}

class TransferWireframe: BaseWireframe {
    private let entryPoint: UIViewController
    private let completionHandler: (() -> Void)?
    private var flowModel = TransferWireframeFlowModel()
    
    private var navigationViewController: UINavigationController?
    
    // MARK: - Flow
    
    init(entryPoint: UIViewController, completionHandler: (() -> Void)?) {
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
                self.pushSummary(view: view)
            }
        )
        
        view.presenter = presenter
        
        self.navigationViewController = UINavigationController(rootViewController: view)
        
        entryPoint.present(navigationViewController!, animated: true, completion: nil)
    }
    
    private func pushSummary(view: UIViewController) {
        let transferModel = TransferModel(sourceIban: "DE12500105170648489890", targetIban: "DE12500105170648489890", amount: flowModel.amount!)
        
        let summaryView = SummaryView()
        let presenter = SummaryPresenter(
            view: summaryView,
            model: transferModel,
            nextHandler: {
                // for testing
                self.navigationViewController?.popViewController(animated: true)
            }
        )
        
        summaryView.presenter = presenter
        
        navigationViewController?.pushViewController(summaryView, animated: true)
    }
}
