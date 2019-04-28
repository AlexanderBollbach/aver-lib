import Foundation

typealias DiffFunction<T: EasyEquatable> = (_ old: Tree<T>, _ new: Tree<T>) -> [TreeMod<T>]

private func _diffStandard<T: EasyEquatable>(old: Tree<T>, new: Tree<T>, path: [Key]) -> [TreeMod<T>] {
    
    let old_new: [(Tree<T>, Tree<T>)] = new.children.compactMap { new in
        if let foundOld = old.children.first(where: { $0.key == new.key }) {
            return (foundOld, new)
        } else {
            return nil
        }
    }
    
    let oldKeys = old.children.map { $0.key }
    let newKeys = new.children.map { $0.key }
    
    let added = new.children.filter { !oldKeys.contains($0.key) }
    let removed = old.children.filter { !newKeys.contains($0.key) }
    
    let entityChanged = old.value.equality != new.value.equality
    let addedChildren = !added.isEmpty
    let removedChildren = !removed.isEmpty
   
    if entityChanged || addedChildren || removedChildren {
        return [
            TreeMod<T>(
                path: path,
                value: new.value,
                added: added,
                removed: removed.map { $0.key}
            )
        ]
    }
    
    var mods = [TreeMod<T>]()
    
    for o_n in old_new {
        mods.append(contentsOf: _diffStandard(old: o_n.0, new: o_n.1, path: path + [o_n.1.key]))
    }

    return mods
}

struct Diffing<T: EasyEquatable> {
    
    var standard: DiffFunction<T> = { old, new in
        return _diffStandard(old: old, new: new, path: [])
    }
}


