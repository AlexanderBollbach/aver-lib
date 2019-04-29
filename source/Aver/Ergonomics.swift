import Foundation

postfix operator -

postfix func - <T>(element: Element<T>) -> Tree<Element<T>> {
    return Tree(key: "0", value: element, children: [])
}


infix operator --

func -- <T>(
    element: Element<T>,
    children: [Tree<Element<T>>]
    ) -> Tree<Element<T>> {
    
    return from(element: element, children: children)
}

private func from<T>(
    element: Element<T>,
    children: [Tree<Element<T>>]
    ) -> Tree<Element<T>> {
    
    return Tree(key: "0", value: element, children: children.incrKeys())
}

extension Array {
    func incrKeys<T>() -> Array<Tree<T>> where Element == Tree<T> {
        return enumerated().map {
            $0.element.withKey(key: "\($0.offset)")
        }
    }
}
