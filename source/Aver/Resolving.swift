import Foundation

typealias ResolveFunction<T> = (_ tree: Tree<T>, _ mods: [TreeMod<T>]) -> Tree<T>

//extension Tree {
//    func updated<U>(with mod: TreeMod<T>) -> Tree where T == Element<U> {
//
//        // special case.  we didn't descend in the differ.  should this even be handled here?
//        if mod.path.isEmpty {
//            return mod.tree
//        }
//
//
//        if mod.path.count > 1 {
//            return Tree(
//                key: self.key,
//                value: self.value,
//                children: children.map { $0.key == mod.path.first! ? $0.updated(with: mod.droppedPath()) : $0 }
//            )
//        } else {
//            return childUpdated(at: mod.path.first!, fn: { _ in mod.tree })
//        }
//    }
//}

struct Resolving<T> {
    var standard: ResolveFunction<Element<T>> = { tree, mods in
        var tree = tree
        for mod in mods {
            tree = updated(tree: tree, mod: mod)
        }
        return tree
    }
}


func updated<T>(tree: Tree<Element<T>>, mod: TreeMod<Element<T>>) -> Tree<Element<T>> {
    
    if mod.path.count == 1 {
        return Tree(key: tree.key, value: tree.value.rendered(with: []), children: tree.children)
    }
    
    let cs = tree.children.map { mod.path.first! == $0.key ? updated(tree: tree, mod: mod.droppedPath()) : $0 }
 
    return Tree(key: tree.key, value: tree.value, children: tree.children)
}
