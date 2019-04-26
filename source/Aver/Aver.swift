class Aver<T> {
    
    let diff: DiffFunction<Element<T>>
    let resolve: ResolveFunction<Element<T>>
    
    private var element: Tree<Element<T>>?
    
    init(
        diff: @escaping DiffFunction<Element<T>> = Diffing().standard,
        resolve: @escaping ResolveFunction<Element<T>> = Resolving().standard
        ) {
        self.diff = diff
        self.resolve = resolve
    }
    
    func render(_ e: Tree<Element<T>>) -> T {
        element = _resolve(e)
//        return element!.render()
        fatalError()
    }
    
    private func _resolve(_ e: Tree<Element<T>>) -> Tree<Element<T>> {
        if let currentElement = self.element {
            return resolve(currentElement, diff(currentElement, e))
        } else {
            return e
        }
    }
}

