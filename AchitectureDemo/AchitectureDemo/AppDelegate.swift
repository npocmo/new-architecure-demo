import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        startApp()
        
        return true
    }
    
    private func startApp() {
        setupWindow()
        
        let wireframe = TransferWireframe()
        wireframe.present()
    }
    
    private func setupWindow() {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
