import Foundation

typealias ResolveFunction<T> = (_ tree: Tree<T>, _ mods: [TreeMod<T>]) -> Tree<T>

extension Tree {
    func updated<U>(with mod: TreeMod<T>) -> Tree where T == Element<U> {

        // special case.  we didn't descend in the differ.  should this even be handled here?
        if mod.path.isEmpty {
            return mod.tree
        }


        if mod.path.count > 1 {
            return Tree(
                key: self.key,
                value: self.value.clearedCache(),
                children: children.map { $0.key == mod.path.first! ? $0.updated(with: mod.droppedPath()) : $0 }
            )
        } else {
            return childUpdated(at: mod.path.first!, fn: { _ in mod.tree })
        }
    }
}

struct Resolving<T> {
    var standard: ResolveFunction<Element<T>> = { tree, mods in
        var tree = tree
        for mod in mods {
            tree = tree.updated(with: mod)
        }
        return tree
    }
}




