import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let r = Aver<String>()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        var e = generateReadme()
        
        print(r.render(e))
        
        return true
    }
    
    func diffSection() -> Tree<Element<String>> {
        return .doc() -- [
            .header("Diffing", level: 2)-,
            .divider()-,
            .text("yadda yadda yadda")-,
            .text("yadda yadda yadda")-,
        ]
    }
    
    func elementsSection() -> Tree<Element<String>> {
        return .doc() -- [
            .header("Elements", level: 2)-,
            .divider()-,
            .text("yadda yadda yadda")-,
            .text("yadda yadda yadda")-,
        ]
    }
    
    func resolvingSection() -> Tree<Element<String>> {
        return .doc() -- [
            .header("Resolving", level: 2)-,
            .divider()-,
            .text("yadda yadda yadda")-,
            .text("yadda yadda yadda")-,
        ]
    }
    
    func renderingSection() -> Tree<Element<String>> {
        return .doc() -- [
            .header("Rendering", level: 2)-,
            .divider()-,
            .text("yadda yadda yadda")-,
            .text("yadda yadda yadda")-,
        ]
    }
    
    func mainSection() -> Tree<Element<String>> {
        
        return .doc() -- [
            .header("Aver", level: 3)-,
            .divider()-,
            .blockQuoted() -- [
                .text("note: the README for Aver is generated by Aver by rendering the following Element tree:")-,
            ],
            .codeBlock() -- [
                .text(readMeText())-
            ],
            .header("topics", level: 4)-,
            .list() -- [
                .link(url: "#elements", text: "elements")-,
                .link(url: "#diffing", text: "diffing")-,
                .link(url: "#resolving", text: "resolving")-,
                .link(url: "#rendering", text: "rendering")-
            ]
        ]
    }
    
    func generateReadme() -> Tree<Element<String>> {
        return .doc() -- [
            mainSection(),
            elementsSection(),
            diffSection(),
            resolvingSection(),
            renderingSection(),
        ]
    }
    
}


private func readMeText() -> String {
    return ""
}
