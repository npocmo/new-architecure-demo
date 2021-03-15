import UIKit

class HomeWireframe: BaseWireframe {
    private let entryPoint: UINavigationController
    private let completionHandler: (() -> Void)?
    
    private var flowModel = TransferWireframeFlowModel()
    
    // MARK: - Flow
    
    init(entryPoint: UINavigationController, completionHandler: (() -> Void)?) {
        self.entryPoint = entryPoint
        self.completionHandler = completionHandler
    }
    
    func present() {
        presentHome()
    }
    
    private func presentHome() {
        let view = HomeView()
        let presenter = HomePresenter(
            view: view,
            openTransferhandler: {
                self.presentTransfer()
            },
            openOrderHandler: {
                self.presentOrder()
            }
        )
        
        view.presenter = presenter
        
        present(on: entryPoint, viewController: view, animated: true)
    }
    
    private func presentTransfer() {
        guard let navigationViewController = navigationViewController else { return }
        
        let wireframe = TransferWireframe(entryPoint: navigationViewController, completionHandler: nil)
        wireframe.present()
    }
    
    private func presentOrder() {
        guard let navigationViewController = navigationViewController else { return }
        
        let wireframe = OrderWireframe(entryPoint: navigationViewController, completionHandler: nil)
        wireframe.present()
    }
}
