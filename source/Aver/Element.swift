import Foundation

struct Element<T> {
    let key: String
    let equality: String
    let render: (_ ts: [T]) -> T
    let children: [Element<T>]
    
    init(
        key: String = "1",
        equality: String = "",
        children: [Element<T>] = [],
        render: @escaping (_ ts: [T]) -> T
        ) {
        self.key = key
        self.equality = equality
        self.render = render
        self.children = children
    }
}

struct Value<T> {
    let key: String
    let value: T
    let children: [Value<T>]
}

struct Mod<T> {
    let path: [String]
    let element: Element<T>
}

extension Mod {
    func droppedPath() -> Mod {
        return Mod(path: Array(path.dropFirst()), element: element)
    }
}

extension Element {
    func withKey(key: String) -> Element {
        return Element(key: key, equality: self.equality, children: self.children, render: self.render)
    }
}

extension Element {
    func with(children: [Element]) -> Element {
        return Element(key: key, equality: equality, children: children, render: render)
    }
}

extension Array {
    func incrKeys<T>() -> Array<AverLib.Element<T>> where Element == AverLib.Element<T> {
        return enumerated().map { $0.element.withKey(key: "\($0.offset)") }
    }
}

typealias Key = String

infix operator --

func --<T>(
    element: Element<T>,
    children: [Element<T>]
    ) -> Element<T> {
    
    return element.with(children: children.incrKeys())
}

