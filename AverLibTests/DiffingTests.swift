import XCTest
@testable import AverLib

func diff<U>(old: Tree<Element<U>>, new: Tree<Element<U>>) -> [TreeMod<Element<U>>] {
    return old.diff(with: new)
}

class DiffingTests: XCTestCase {
    
    let doc = MarkDownElements().doc
    let list = MarkDownElements().list
    let newLine = MarkDownElements().newLine()
    let text = MarkDownElements().text
    
    func test_diff1() {
        
        let md = MarkDownElements()
        
        let mods = diff(
            old: doc() -- [
                list() -- [
                    text("1")-
                ],
                text("still-cached")-
            ],
            new: doc() -- [
                list() -- [
                    text("1")-,
                    text("added")-
                ],
                text("still-cached")-
            ]
        )
        
        let em = TreeMod(
            path: ["0"],
            value: md.list(),
            added: [(md.text("added")-).withKey(key: "1")],
            removed: []
        )
        
        XCTAssert(mods == [em])
    }
    
    func test_diff2() {
        
        let md = MarkDownElements()
        
        let initialTree = md.doc() -- [
            md.list() -- [
                md.text("1")-,
                md.text("2")-
            ],
            md.text("1")-
        ]
        
        let updatedTree = md.doc() -- [
            md.list() -- [
                md.text("1")-
            ],
            md.text("1-CHANGED")-
        ]
        
        let mods = initialTree.diff(with: updatedTree)
        
        let mod1 = TreeMod(
            path: ["0"],
            value: md.list(),
            added: [],
            removed: ["1"]
        )
        
        let mod2 = TreeMod(
            path: ["1"],
            value: md.text("1-CHANGED"),
            added: [],
            removed: []
        )
        
        XCTAssert(mods == [mod1, mod2])
    }
    
    func test_diff3() {
        
        let md = MarkDownElements.init()
        
        let initialTree = md.doc() -- [
            md.text("1")-,
            md.text("2")-
        ]
        
        let updatedTree = md.doc() -- [
            md.newLine()-
        ]
        
        let mods = initialTree.diff(with: updatedTree)
        
        let mod1 = TreeMod(
            path: [],
            value: md.doc(),
            added: [md.newLine()-],
            removed: ["0", "1"]
        )
        
        XCTAssert(mods.first == mod1)
    }
    
    func test_diff4() {
        
        let md = MarkDownElements.init()
        
        let initialTree = md.doc() -- [
            md.text("1")-,
            md.text("2")-
        ]
        
        let updatedTree = md.doc() -- [
            md.text("1")-
        ]
        
        let mods = initialTree.diff(with: updatedTree)
        
        let mod1 = TreeMod(
            path: [],
            value: md.doc(),
            added: [],
            removed: ["1"]
        )
        
        XCTAssert(mods.first == mod1)
    }
    
    func test_diff5() {
        
        let mods = diff(
            old: doc() -- [
                text("l1")-
            ],
            new: doc() -- [
                text("l1-changed")-
            ]
        )
        
        let em = TreeMod(path: ["0"], value: text("l1-changed"), added: [], removed: [])
        
        XCTAssert(mods == [em])
    }
    
    func test_diffNone() {
        
        let mods = diff(
            old: list()-,
            new: list()-
        )
        
        XCTAssert(mods.isEmpty)
    }
    
    func test_diffTwo() {
        
        let l1 = list() -- [
            text("l1")-
        ]
        
        let l2 = list() -- [
            text("l2")-
        ]
        
        let l1_changed = list() -- [
            text("l1-changed")-
        ]
        
        let l2_changed = list() -- [
            text("l2-changed")-
        ]
        
        let mods = diff(
            old: doc() -- [
                l1,
                l2
            ],
            new: doc() -- [
                l1_changed,
                l2_changed
            ]
        )
        
        XCTAssert(mods.count == 2)
    }
}
