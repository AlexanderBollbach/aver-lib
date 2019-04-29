
import XCTest
@testable import AverLib

class TreeTests: XCTestCase {

    func test1() {
        
        let t1: Tree<Element<String>> = .list() -- [.text("foo")-]
        let t2: Tree<Element<String>> = .list() -- [.text("foo")-, .text("bar")-]
        
        let added = t2.added(from: t1)
        
        XCTAssert(added == [.text("bar")-.withKey(key: "1")])
    }
    
    func test2() {
        
        let t1: Tree<Element<String>> = .list() -- [.text("foo")-, .text("bar")-]
        let t2: Tree<Element<String>> = .list() -- [.text("foo")-]
        
        let removed = t2.removed(from: t1)
        
        XCTAssert(removed == [ .text("bar")-.withKey(key: "1")])
    }
}
