protocol EasyEquatable {
    var equality: String { get }
}

protocol DebugLoggable {
    var debugLog: String { get }
}

protocol Keyed {
    var key: Key { get }
}

typealias Key = String
