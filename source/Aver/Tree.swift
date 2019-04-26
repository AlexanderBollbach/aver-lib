import Foundation

typealias Key = String

struct Tree<T> {
    let key: Key
    let value: T
    let children: [Tree<T>]
}

extension Tree: Equatable where T: EasyEquatable {
    static func == (lhs: Tree, rhs: Tree) -> Bool {
        return lhs.key == rhs.key && lhs.value.equality == rhs.value.equality && lhs.children == rhs.children
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

extension Tree {
    func childUpdated(at key: Key, fn: @escaping (Tree) -> Tree) -> Tree {
        return Tree(
            key: key,
            value: value,
            children: children.map { $0.key == key ? fn($0) : $0 }
        )
    }
}

struct TreeMod<T> {
    let path: [Key]
    let tree: Tree<T>
}

extension TreeMod: Equatable where T: EasyEquatable {
    static func == (lhs: TreeMod, rhs: TreeMod) -> Bool {
        return lhs.path == rhs.path && lhs.tree == rhs.tree
    }
}

extension TreeMod {
    func droppedPath() -> TreeMod {
        return TreeMod(path: Array(path.dropFirst()), tree: tree)
    }
}

protocol Keyed {
    var key: Key { get }
}

extension Tree: DebugLoggable where T: DebugLoggable {
    
    var debugLog: String {
        return log()
    }
    
    func log(depth: Int = 0) -> String {
        let spacing = String(repeating: " ", count: depth * 4)
        var s = spacing + "\(key) - \(value.debugLog)"
        for c in children {
            s = s + c.log(depth: depth + 1)
        }
        return s
    }
}

extension Tree {

    mutating func render<U>() where T == Element<U> {
        let cs: [Tree] = children.map { var a = $0 ; a.render() ; return a }
        self = Tree(key: key, value: value.rendered(with: cs.map { $0.value.cache! }), children: cs)
    }
}

extension Element {
    
    func rendered(with values: [T]) -> Element {
        return Element(name: name, equality: equality, cache: render(values), render: render)
    }
}
