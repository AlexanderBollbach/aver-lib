import Foundation

protocol EasyEquatable {
    var equality: String { get }
}

protocol DebugLoggable {
    var debugLog: String { get }
}

struct Element<T>: EasyEquatable {
    let name: String
    let equality: String
    var cache: T?
    let render: (_ values: [T]) -> T
    
    init(name: String, equality: String = "", cache: T? = nil, render: @escaping (_ values: [T]) -> T) {
        self.name = name
        self.equality = equality
        self.render = render
        self.cache = cache
    }
}

extension Element: DebugLoggable {
    var debugLog: String {
        return "\(name) \(cache != nil ? "(CACHED)" : "")"
    }
}

extension Element {
    func rendered(values: [T]) -> Element {
        return Element(name: name, equality: equality, cache: self.render(values), render: self.render)
    }
    
    func clearedCache() -> Element {
        return Element(name: name, equality: equality, cache: nil, render: render)
    }
}

