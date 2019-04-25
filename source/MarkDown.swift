import Foundation

struct MarkDownElements {
    func newLine() -> Element<String> {
        return Element(name: "newLine", render: { _ in return "\n" })
    }
    
    func text(_ text: String) -> Element<String> {
        return Element(name: "text", equality: text) { _ in return text }
    }
    
    func list() -> Element<String> {
        return Element(name: "list") { $0.map { "- \($0)" }.joined(separator: "\n") }
    }
    
    func doc() -> Element<String> {
        return Element(name: "doc") { $0.joined(separator: "\n") }
    }
}

