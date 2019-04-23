//
//  FilteringStuff.swift
//  asdfasdfasdfs
//
//  Created by Alexander Bollbach on 4/5/19.
//  Copyright © 2019 Alexander Bollbach. All rights reserved.
//

import Foundation


enum Size {
    case small
    case big
}
enum Color {
    case white
    case black
}
struct Product {
    let size: Size
    let color: Color
    let name: String
}

extension Product: Colored, Sized { }

protocol Colored {
    var color: Color { get }
}
protocol Sized {
    var size: Size { get }
}

// filter
protocol Filter {
    associatedtype T
    func filter<Spec>(items: [T], specs: Spec) -> [T]
        where Spec: Specification, Spec.T == T
}

struct GenericFilter<T>: Filter {
    func filter<Spec>(items: [T], specs: Spec) -> [T]
        where Spec : Specification, T == Spec.T {
            return items.filter { specs.isSatisfied(item: $0) }
    }
}

// specs
protocol Specification {
    associatedtype T
    func isSatisfied(item: T) -> Bool
}

struct ColorSpec<T: Colored>: Specification {
    let color: Color
    func isSatisfied(item: T) -> Bool { return item.color == color }
}
struct SizeSpec<T: Sized>: Specification {
    let size: Size
    func isSatisfied(item: T) -> Bool { return item.size == size }
}


func test() {
    
    
    let product1 = Product(size: .big, color: .black, name: "big and black")
    let product2 = Product(size: .small, color: .white, name: "small and white")
    
    let colorSpec = ColorSpec<Product>(color: .white)
    
    let filter = GenericFilter<Product>()
    
    
    let result = filter.filter(items: [product1, product2], specs: colorSpec)
    
    print(result)
    
    
}
