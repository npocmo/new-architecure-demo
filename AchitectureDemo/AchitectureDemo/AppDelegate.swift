import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var wireframe: TransferWireframe?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        wireframe = TransferWireframe()
        wireframe?.present()
        return true
    }
    
    private func setupWindow() {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = false

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
