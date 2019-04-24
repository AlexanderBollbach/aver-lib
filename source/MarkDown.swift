import Foundation

struct MarkDownElements {
    func newLine() -> Element<String> {
        return Element(render: { _ in return "\n" })
    }
    
    func text(_ text: String) -> Element<String> {
        return Element(equality: text) { _ in return text }
    }
    
    func list() -> Element<String> {
        return Element { $0.map { "- \($0)" }.joined(separator: "\n") }
    }
    
    func doc() -> Element<String> {
        return Element { $0.joined(separator: "\n") }
    }
}

