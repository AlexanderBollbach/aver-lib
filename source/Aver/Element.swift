import Foundation

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
