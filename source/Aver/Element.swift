import Foundation

typealias Key = String

protocol Keyed {
    var key: Key { get }
}

protocol EasyEquatable {
    var equality: String { get }
}

struct Tree<T> {
    let key: Key
    let value: T
    let children: [Tree<T>]
}

struct Element<T>: EasyEquatable {
    let equality: String
    let render: (_ values: [T]) -> T
    
    init(equality: String = "", render: @escaping (_ values: [T]) -> T) {
        self.equality = equality
        self.render = render
    }
}

struct Mod<T> {
    let path: [Key]
    let value: T
}

extension Mod {
    func droppedPath() -> Mod {
        return Mod(path: Array(path.dropFirst()), value: value)
    }
}

extension Tree {
    func withKey(key: Key) -> Tree {
        return Tree(
            key: key,
            value: self.value,
            children: self.children
        )
    }
}

extension Tree {
    func with(children: [Tree]) -> Tree {
        return Tree(
            key: key,
            value: value,
            children: children
        )
    }
}

extension Array {
    func incrKeys<T>() -> Array<Tree<T>> where Element == Tree<T> {
        return enumerated().map {
            $0.element.withKey(key: "\($0.offset)")
        }
    }
}


infix operator --

func -- <T>(
    element: Element<T>,
    children: [() -> Tree<Element<T>>]
    ) -> Tree<Element<T>> {
    
    return from(element: element, children: children)
}

private func from<T>(
    element: Element<T>,
    children: [() -> Tree<Element<T>>]
    ) -> Tree<Element<T>> {
    
    fatalError()
}
