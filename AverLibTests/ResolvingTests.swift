import XCTest
@testable import AverLib

class ResolvingTests: XCTestCase {
    
    func testResolve1() {
        
        let old: Tree<Element<String>> = .doc() -- [
            .text("2")-
        ]
        
        let new: Tree<Element<String>> = .doc() -- [
            .text("2-changed")-
        ]

        let mods = diff(old: old, new: new)

        let result = old.resolve(mods: mods)
        
        XCTAssert(result == new)

    }

    func testResolve2() {
        
        let old: Tree<Element<String>> = .doc() -- [
            .text("2")-
        ]
        
        let new: Tree<Element<String>> = .doc()-
        
        let mods = old.diff(with: new)

        XCTAssert(mods == [TreeMod(path: [], value: .doc(), added: [], removed: ["0"])])
        
        let r = old.resolve(mods: mods)

        XCTAssert(r == new)
    }

    func testResolve3() {

        let old: Tree<Element<String>> = .doc() -- [
            .list() -- [
                .text("1")-
            ],
            .text("foo")-
        ]
        
        let new: Tree<Element<String>> = .doc() -- [
            .list() -- [
                .text("1")-,
                .text("2")-
            ],
            .text("foo")-
        ]
        
        XCTAssert(new == old.resolve(mods: old.diff(with: new)))
    }
}
