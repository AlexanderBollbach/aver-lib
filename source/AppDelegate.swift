import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let r = Aver<String>()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        generateReadme()
        
        return true
    }
    
    func generateReadme() {
        
        let tr: Tree<Element<String>> = .doc() -- [
            .header("Aver")-,
            .divider()-,
            .text("topics")-,
            .list() -- [
                .text("diffing")-,
                .text("resolving")-,
                .text("rendering")-,
            ]
        ]
        
        let result = r.render(tr)
        
        print(result)
        print(tr.log())
    }
}
