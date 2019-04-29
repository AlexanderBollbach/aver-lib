import XCTest
@testable import AverLib

class ResolvingTests: XCTestCase {
    
    let doc = MarkDownElements().doc
    let list = MarkDownElements().list
    let newLine = MarkDownElements().newLine()
    let text = MarkDownElements().text
    
    func testResolve1() {
        
        let old = doc() -- [
            text("2")-
        ]
        
        let new = doc() -- [
            text("2-changed")-
        ]

        let mods = diff(old: old, new: new)

        let result = old.resolve(mods: mods)
        
        XCTAssert(result == new)

    }

    func testResolve2() {
        
        let old = doc() -- [
            text("2")-
        ]
        
        let new = doc()-
        
        let mods = old.diff(with: new)

        XCTAssert(mods == [TreeMod(path: [], value: doc(), added: [], removed: ["0"])])
        
        let r = old.resolve(mods: mods)

        XCTAssert(r == new)
    }

    func testResolve3() {

        let old = doc() -- [
            list() -- [
                text("1")-
            ],
            text("foo")-
        ]
        
        let new = doc() -- [
            list() -- [
                text("1")-,
                text("2")-
            ],
            text("foo")-
        ]
        
        XCTAssert(new == old.resolve(mods: old.diff(with: new)))
    }
}
