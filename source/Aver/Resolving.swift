import Foundation

typealias ResolveFunction<T> = (_ tree: Tree<T>, _ mods: [TreeMod<T>]) -> Tree<T>

func resolveStandard<T>(tree: Tree<T>, mods: [TreeMod<T>]) -> Tree<T> {
    return mods.reduce(tree, { $0.updated(with: $1) })
}

extension Tree {
    func updated(with mod: TreeMod<T>) -> Tree {
        if mod.path.count > 1 {
            return Tree(
                key: self.key,
                value: self.value,
                children: children.map { $0.key == mod.path.first! ? $0.updated(with: mod.droppedPath()) : $0 }
            )
        } else {
            return childUpdated(at: mod.path.first!, fn: { _ in mod.tree })
        }
    }
}

struct Resolving<T: EasyEquatable> {
    var standard: ResolveFunction<T> = { tree, mods in
        return resolveStandard(tree: tree, mods: mods)
    }
}
