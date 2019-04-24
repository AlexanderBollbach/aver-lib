import Foundation

protocol EasyEquatable {
    var equality: String { get }
}

struct Element<T>: EasyEquatable {
    let equality: String
    let render: (_ values: [T]) -> T
    
    init(equality: String = "", render: @escaping (_ values: [T]) -> T) {
        self.equality = equality
        self.render = render
    }
}





