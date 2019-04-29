import XCTest
@testable import AverLib

class RenderingTests: XCTestCase {
   
    func test1() {

        var t1: Tree<Element<String>> = .doc() -- [
            .text("1")-
        ]
        
        XCTAssert(t1.value.cache == nil)
        
        t1.render()
        
        XCTAssert(t1.value.cache == "1")
    }
    
    func test2() {
        
        var t1: Tree<Element<String>> = .doc() -- [
            .list() -- [
                .text("1")-,
                .text("2")-
            ],
            .text("1")-
        ]
        
        XCTAssert(t1.value.cache == nil)
        
        t1.render()
        
        XCTAssert(t1.value.cache == "- 1\n- 2\n1")
        
        let t2: Tree<Element<String>> = .doc() -- [
            .list() -- [
                .text("3")-
            ],
            .text("1")-
        ]
        
        t1 = t1.resolve(mods: t1.diff(with: t2))
        
        // caches cleared
        XCTAssert(t1.children[0].value.cache ==  nil)
        XCTAssert(t1.children[1].value.cache ==  "1")
        
        t1.render()
        
        XCTAssert(t1.value.cache ==  "- 3\n1")
    }
    
    func testResolve3() {
    
        var old: Tree<Element<String>> = .doc() -- [
            .list() -- [
                .text("1")-,
                .list() -- [
                    .text("l1")-
                ]
            ],
            .text("text")-
        ]

        let new: Tree<Element<String>> = .doc() -- [
            .list() -- [
                .text("1")-,
                .list() -- [
                    .text("l1-changed")-
                ]
            ],
            .text("text")-
        ]
        
        XCTAssert(old.value.cache == nil)
        
        old.render()
        XCTAssert(old.value.cache == "- 1\n- - l1\ntext")
        
        let mods = old.diff(with: new)
        var final = old.resolve(mods: mods)
        
        XCTAssert(final.value.cache == nil)
        
        final.render()
        XCTAssert(final == new)
        
    }
}
