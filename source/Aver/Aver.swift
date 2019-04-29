class Aver<T> {
    
    private var element: Tree<Element<T>>?

    func render(_ e: Tree<Element<T>>) -> T {
        element = _resolve(e)
        element!.render()
        return element!.value.cache!
    }
    
    private func _resolve(_ e: Tree<Element<T>>) -> Tree<Element<T>> {
        if let currentElement = self.element {
            return currentElement.resolve(mods: currentElement.diff(with: e))
        } else {
            return e
        }
    }
}
