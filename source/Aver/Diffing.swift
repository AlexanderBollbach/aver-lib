import Foundation

extension Tree {
    
    // if the key is the same, and the name ("type") is the same, it is only rerendered not replaced
    func isEquivalent<U>(with tree: Tree) -> Bool
        where T == AverLib.Element<U> {
            return self.key == tree.key && self.value.name == tree.value.name
    }
    
    func contains<U>(new: Tree) -> Bool
        where T == AverLib.Element<U> {
            return children.contains(where: { $0.isEquivalent(with: new) })
    }
    
    func added<U>(from old: Tree) -> [Tree]
        where T == AverLib.Element<U> {
            return children.filter { !old.contains(new: $0) }
    }
    
    func removed<U>(from old: Tree) -> [Tree]
        where T == AverLib.Element<U> {
            return old.children.filter { !self.contains(new: $0) }
    }
    
    func unchanged<U>(from old: Tree) -> [(Tree, Tree)]
        where T == AverLib.Element<U> {
            return children.compactMap { child in
                old.children.first(where: { $0.isEquivalent(with: child) }).map { ($0, child) }
            }
    }
}

extension Tree {
    
    func diff<U>(with new: Tree, path: [Key] = []) -> [TreeMod<T>] where T == Element<U> {
        
        let added = new.added(from: self)
        let removed = new.removed(from: self)
        let unchanged = new.unchanged(from: self)
        
        let entityChanged = value.equality != new.value.equality || value.name != new.value.name
        
        var mods = [TreeMod<T>]()
        
        if entityChanged || !added.isEmpty || !removed.isEmpty {
            mods.append(TreeMod<T>(
                path: path,
                value: new.value,
                added: added,
                removed: removed.map { $0.key}
            ))
        }
        
        for (old, new) in unchanged {
            mods.append(contentsOf: old.diff(with: new, path: path + [new.key]))
        }
        
        return mods
    }
}

