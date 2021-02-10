import UIKit

class BaseWireframe {
    
    private var navigationViewController: UINavigationController?
    
    func present(entryPoint: UINavigationController, viewController: UIViewController) {
        navigationViewController = UINavigationController(rootViewController: viewController)
        navigationViewController?.modalPresentationStyle = .overFullScreen
        
        guard let navigationViewController = navigationViewController else {
            return
        }
        navigationViewController.navigationBar.isHidden = true
        
        entryPoint.present(navigationViewController, animated: true, completion: nil)
    }
    
    func push(viewController: UIViewController) {
        self.navigationViewController?.pushViewController(viewController, animated: true)
    }
}
