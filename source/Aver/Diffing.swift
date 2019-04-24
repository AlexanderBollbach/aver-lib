import Foundation

typealias DiffFunction<T: EasyEquatable> = (_ old: Tree<T>, _ new: Tree<T>) -> [TreeMod<T>]

private func _diffStandard<T: EasyEquatable>(old: Tree<T>, new: Tree<T>, path: [Key]) -> [TreeMod<T>] {
    
    let oldKeys = old.children.map { $0.key }
    let newKeys = new.children.map { $0.key }
    
    let added = new.children.filter { !oldKeys.contains($0.key) }
    let deleted = old.children.filter { !newKeys.contains($0.key) }
    
    let entityChanged = old.value.equality != new.value.equality
    let childrenAmountChanged = !added.isEmpty || !deleted.isEmpty
    
    var childrenEqualityChanged = false
    
    for new in new.children {
        if let old = old.children.first(where: { $0.key == new.key }) {
            if old.value.equality != new.value.equality {
                childrenEqualityChanged = true
            }
        }
    }
    
    if entityChanged || childrenAmountChanged || childrenEqualityChanged {
        return [TreeMod(path: path, tree: new)]
    }
    
    var mods = [TreeMod<T>]()
    
    for new in new.children {
        if let old = old.children.first(where: { $0.key == new.key }) {
            mods.append(contentsOf: _diffStandard(old: old, new: new, path: [new.key] + path))
        }
    }
    
    return mods
}

struct Diffing<T: EasyEquatable> {
    
    var standard: DiffFunction<T> = { old, new in
        return _diffStandard(old: old, new: new, path: [])
    }
}


