import Foundation

extension Element where T == String {
    static func newLine() -> Element {
        return Element(name: "newLine", render: { _ in return "\n" })
    }
    
    static func text(_ text: String) -> Element {
        return Element(name: "text", equality: text) { _ in return text }
    }
    
    static func list() -> Element {
        return Element(name: "list") { $0.map { "- \($0)" }.joined(separator: "\n") }
    }
    
    static func doc() -> Element {
        return Element(name: "doc") { $0.joined(separator: "\n") }
    }
    
    static func header(_ title: String, level: Int = 1) -> Element {
        if level > 4 { fatalError() }
        return Element(name: "header", equality: title) { _ in "\(String.init(repeating: "#", count: level)) \(title)" }
    }
    
    static func divider() -> Element {
        return Element(name: "divider") { _ in "---" }
    }
    
    static func blockQuoted() -> Element {
        return Element(name: "blockQuoted") { $0.map { "> \($0)\n" }.joined() }
    }
    
    static func codeBlock() -> Element {
        return Element(name: "codeBlock") { "```\n\($0.joined())\n```" }
    }
    
    static func horizontal() -> Element {
        return Element(name: "horizontal") { _ in "<hr />" }
    }
    
    static func link(url: String, text: String) -> Element {
        return Element(name: "link", equality: "\(url)\(text)") { _ in "[\(text)](\(url))" }
    }
}

