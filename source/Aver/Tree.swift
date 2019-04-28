import Foundation

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
    func withKey(key: Key) -> Tree { return Tree(key: key, value: value, children: children) }
    func with(children: [Tree]) -> Tree { return Tree(key: key, value: value, children: children) }
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
    let value: T
    let added: [Tree<T>]
    let removed: [Key]
}

extension TreeMod: Equatable where T: EasyEquatable {
    static func == (lhs: TreeMod, rhs: TreeMod) -> Bool {
        return lhs.path == rhs.path && lhs.value.equality == rhs.value.equality && lhs.added == rhs.added && lhs.removed == rhs.removed
    }
}

extension TreeMod {
    func droppedPath() -> TreeMod { return TreeMod(path: Array(path.dropFirst()), value: value, added: added, removed: removed) }
}

extension Tree: DebugLoggable where T: DebugLoggable {
    
    var debugLog: String { return log() }
    
    func log(depth: Int = 0) -> String {
        let spacing = String(repeating: " ", count: depth * 4)
        var s = spacing + "\(key) - \(value.debugLog)\n"
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


