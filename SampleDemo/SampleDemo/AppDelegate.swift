import UIKit

public let serviceLocator = ServiceLocator.instance

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    internal var window: UIWindow?
    private var navigationController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        startApp()
        return true
    }
    
    private func startApp() {
        setupWindow()
        showTransferWireframe()
    }
    
    private func setupWindow() {
        navigationController = UINavigationController(rootViewController: UIViewController())
        navigationController?.navigationBar.isHidden = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func showTransferWireframe() {
        guard let navigationController = navigationController else { return }
        
        let wireframe = HomeWireframe(entryPoint: navigationController, completionHandler: nil)
        wireframe.present()
    }
}
