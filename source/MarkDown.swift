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
}

