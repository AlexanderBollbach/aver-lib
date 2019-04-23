import Foundation

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

func doc1() -> Tree<Element<String>> {
    return doc() -- [
        text("2"),
        list() -- [
            text("list text 1"),
            text("list text 2")
        ]
    ]
}



//
//func doc2() -> Element<String> {
//    return doc() -- [
//        list() -- [
//            text("1"),
//            text("3")
//        ]
//    ]
//}
