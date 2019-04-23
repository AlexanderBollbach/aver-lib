class Aver<T> {
    
    let diff: DiffFunction<T>
    let resolve: ResolveFunction<T>
    
    private var element: Element<T>?
    private var value: Value<T>?
    
    init(p
        diff: @escaping DiffFunction<T> = diffStandard,
        resolve: @escaping ResolveFunction<T> = resolveStandard
        ) {
        self.diff = diff
        self.resolve = resolve
    }
    
    func render(_ e: Element<T>) -> T {
        resolveNewValue(e)
        return value!.value
    }
    
    private func resolveNewValue(_ e: Element<T>) {
        if let currentElement = self.element, let currentValue = self.value {
            value = resolve(currentValue, diff(currentElement, e))
        } else {
            element = e
            value = Value.fromElement(e)
        }
    }
}

