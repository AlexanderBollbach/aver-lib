import Foundation

typealias DiffFunction<T> = (_ old: Element<T>, _ new: Element<T>) -> [Mod<T>]

func diffStandard<T>(old: Element<T>, new: Element<T>) -> [Mod<T>] {
    return diffStandard(old: old, new: new, path: [])
}

private func diffStandard<T>(old: Element<T>, new: Element<T>, path: [String]) -> [Mod<T>] {
    
    let oldKeys = old.children.map { $0.key }
    let newKeys = new.children.map { $0.key }
    
    let added = new.children.filter { !oldKeys.contains($0.key) }
    let deleted = old.children.filter { !newKeys.contains($0.key) }
    
    let entityChanged = old.equality != new.equality
    let childrenAmountChanged = !added.isEmpty || !deleted.isEmpty
    
    var childrenEqualityChanged = false
    
    for new in new.children {
        if let old = old.children.first(where: { $0.key == new.key }) {
            if old.equality != new.equality {
                childrenEqualityChanged = true
            }
        }
    }
    
    if entityChanged || childrenAmountChanged || childrenEqualityChanged {
        return [Mod(path: path, element: new)]
    }
    
    var mods = [Mod<T>]()
    
    for new in new.children {
        if let old = old.children.first(where: { $0.key == new.key }) {
            mods.append(contentsOf: diffStandard(old: old, new: new, path: [new.key] + path))
        }
    }
    
    return mods
}
