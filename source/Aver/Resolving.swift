import Foundation

extension Tree {
    
    func resolve<U>(mods: [TreeMod<T>]) -> Tree
        where T == Element<U> {
            
            var final = self
            
            for mod in mods {
                final = final.updated(with: mod)
            }
            
            return final
    }
    
    func updated<U>(with mod: TreeMod<T>) -> Tree where T == Element<U> {
        if !mod.path.isEmpty {
            return Tree(
                key: self.key,
                value: self.value.clearedCache(),
                children: children.map { $0.key == mod.path.first! ? $0.updated(with: mod.droppedPath()) : $0 }
            )
        } else {
            return updated(with: mod.value, added: mod.added, removed: mod.removed)
        }
    }
    
    func updated<U>(with value: T, added: [Tree], removed: [Key]) -> Tree where T == Element<U> {
        
        var cs = children.filter { !removed.contains($0.key) }
        cs.append(contentsOf: added)
        
        return Tree(key: key, value: value, children: cs)
        
    }
}



