extension Tree {
    
    mutating func render<U>() where T == Element<U> {
        let cs: [Tree] = children.map { var a = $0 ; a.render() ; return a }
        self = Tree(key: key, value: value.rendered(with: cs.map { $0.value.cache! }), children: cs)
    }
    
}

extension Element {
    func rendered(with values: [T]) -> Element {
        return Element(name: name, equality: equality, cache: render(values), render: render)
    }
    
    func clearedCache() -> Element {
        return Element(name: name, equality: equality, cache: nil, render: render)
    }
}
