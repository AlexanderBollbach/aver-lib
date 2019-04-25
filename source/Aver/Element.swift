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
    let render: (_ values: [T]) -> T
    
    init(name: String, equality: String = "", render: @escaping (_ values: [T]) -> T) {
        self.name = name
        self.equality = equality
        self.render = render
    }
}

extension Element: DebugLoggable {
    var debugLog: String {
        return name
    }
}


