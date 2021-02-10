import UIKit

class BaseWireframe {
    
    private var navigationViewController: UINavigationController?
    
    func present(on entryPoint: UINavigationController, viewController: UIViewController, animated: Bool) {
        navigationViewController = UINavigationController(rootViewController: viewController)
        navigationViewController?.modalPresentationStyle = .overFullScreen
        
        guard let navigationViewController = navigationViewController else {
            return
        }
        navigationViewController.navigationBar.isHidden = true
        
        entryPoint.present(navigationViewController, animated: animated, completion: nil)
    }
    
    func push(viewController: UIViewController, animated: Bool) {
        self.navigationViewController?.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool) {
        navigationViewController?.popViewController(animated: animated)
    }
}
