import UIKit

class BaseWireframe {
    
    // MARK: - Transitions
    
    func present(_ view: UIViewController?) {
        guard let view = view else { return }
        
        let navigation = createNavigationController(view)
        
        if let topController = visibleViewController() {
            topController.present(navigation, animated: true, completion: nil)
        }
    }
    
    func push(_ view: UIViewController?) {
        guard let view = view else { return }

        pushTo(visibleNavigationController(), view: view, animated: true)
    }
    
    // MARK: - Transitions Helper Methods
    
    private func pushTo(_ navigationController: UINavigationController, view: UIViewController, animated: Bool) {
        navigationController.pushViewController(view, animated: animated)
    }
    
    private func createNavigationController(_ rootViewController: UIViewController) -> UINavigationController {
        let controller = UINavigationController(rootViewController: rootViewController)
        controller.modalPresentationStyle = .overFullScreen
        controller.navigationBar.isHidden = true
        return controller
    }
    
    private func visibleViewController() -> UIViewController? {
        guard let app = UIApplication.shared.delegate as? AppDelegate, var topController = app.window?.rootViewController else {
            return nil
        }
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        if let topNavigation = topController as? UINavigationController, let topController = topNavigation.viewControllers.last {
            return topController
        }
        
        return topController
    }
    
    private func visibleNavigationController() -> UINavigationController {
        return navigationControllerFrom(visibleViewController()!)!
    }
    
    private func navigationControllerFrom(_ source: UIViewController) -> UINavigationController? {
        var navigationController = source as? UINavigationController
        if navigationController == nil {
            navigationController = source.navigationController
        }
        
        return navigationController
    }
}
