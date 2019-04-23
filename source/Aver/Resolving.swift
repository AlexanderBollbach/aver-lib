import Foundation

typealias ResolveFunction<T> = (_ value: Value<T>, _ mods: [Mod<T>]) -> Value<T>

func resolveStandard<T>(value: Value<T>, mods: [Mod<T>]) -> Value<T> {
    
    
    
    for mod in mods {
        if mod.path.isEmpty {
            return Value.fromElement(mod.element)
        } else {
            return value.updated(mod: mod)
        }
    }
    
    fatalError()
}

extension Value {
    
    func updated(mod: Mod<T>) -> Value {
        if mod.path.count > 1 {
            return updated(mod: mod.droppedPath())
        } else {
            return Value.fromElement(mod.element)
        }
    }
    
    static func fromElement(_ element: Element<T>) -> Value {
        
        let values = element.children.map {
            Value.fromElement($0)
        }
        
        return Value<T>(
            key: element.key,
            value: element.render(values.map { $0.value }),
            children: values
        )
    }
}
