import Foundation

typealias ResolveFunction<T> = (_ tree: Tree<T>, _ mods: [Mod<T>]) -> Tree<T>

func resolveStandard<T>(tree: Tree<T>, mods: [Mod<T>]) -> Tree<T> {
    fatalError()
}

struct Resolving<T: EasyEquatable> {
    var standard: ResolveFunction<T> = { tree, mods in
        return resolveStandard(tree: tree, mods: mods)
    }
}

//extension Value {
//
//    func updated(mod: Mod<T>) -> Value {
//        if mod.path.count > 1 {
//            return updated(mod: mod.droppedPath())
//        } else {
//            return Value.fromElement(mod.element)
//        }
//    }
//
//    static func fromElement(_ element: Element<T>) -> Value {
//
//        let values = element.children.map {
//            Value.fromElement($0)
//        }
//
//        return Value<T>(
//            key: element.key,
//            value: element.render(values.map { $0.value }),
//            children: values
//        )
//    }
//}
