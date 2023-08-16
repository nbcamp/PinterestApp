import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()

        window?.rootViewController = {
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [
                createNavigationController(root: HomeViewController(), icon: "house"),
                createNavigationController(root: NewPostViewController(), icon: "plus.app"),
                createNavigationController(root: ProfileViewController(), icon: "person"),
            ]
            return tabBarController
        }()

        func createNavigationController(root viewController: UIViewController, icon: String) -> UINavigationController {
            let navigationController = UINavigationController(rootViewController: viewController)
            let tabBarItem = UITabBarItem(title: nil, image: .init(systemName: icon), selectedImage: .init(systemName: "\(icon).fill"))
            navigationController.tabBarItem = tabBarItem
            return navigationController
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
