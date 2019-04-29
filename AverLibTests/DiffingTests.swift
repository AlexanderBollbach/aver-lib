import XCTest
@testable import AverLib

func diff<U>(old: Tree<Element<U>>, new: Tree<Element<U>>) -> [TreeMod<Element<U>>] {
    return old.diff(with: new)
}

class DiffingTests: XCTestCase {
   
    func test_diff1() {
        
        let mods: [TreeMod<Element<String>>] = diff(
            old: .doc() -- [
                .list() -- [
                    .text("1")-
                ],
                .text("still-cached")-
            ],
            new: .doc() -- [
                .list() -- [
                    .text("1")-,
                    .text("added")-
                ],
                .text("still-cached")-
            ]
        )
        
        let em = TreeMod<Element<String>>(
            path: ["0"],
            value: .list(),
            added: [(.text("added")-).withKey(key: "1")],
            removed: []
        )
        
        XCTAssert(mods == [em])
    }
    
    func test_diff2() {
        
        let initialTree: Tree<Element<String>> = .doc() -- [
            .list() -- [
                .text("1")-,
                .text("2")-
            ],
            .text("1")-
        ]
        
        let updatedTree: Tree<Element<String>> = .doc() -- [
            .list() -- [
                .text("1")-
            ],
            .text("1-CHANGED")-
        ]
        
        let mods = initialTree.diff(with: updatedTree)
        
        let mod1 = TreeMod<Element<String>>(
            path: ["0"],
            value: .list(),
            added: [],
            removed: ["1"]
        )
        
        let mod2 = TreeMod<Element<String>>(
            path: ["1"],
            value: .text("1-CHANGED"),
            added: [],
            removed: []
        )
        
        XCTAssert(mods == [mod1, mod2])
    }
    
    func test_diff3() {
        
        let initialTree: Tree<Element<String>> = .doc() -- [
            .text("1")-,
            .text("2")-
        ]
        
        let updatedTree: Tree<Element<String>> = .doc() -- [
            .newLine()-
        ]
        
        let mods = initialTree.diff(with: updatedTree)
        
        let mod1 = TreeMod(
            path: [],
            value: .doc(),
            added: [.newLine()-],
            removed: ["0", "1"]
        )
        
        XCTAssert(mods.first == mod1)
    }
    
    func test_diff4() {
        
        let initialTree: Tree<Element<String>> = .doc() -- [
            .text("1")-,
            .text("2")-
        ]
        
        let updatedTree: Tree<Element<String>> = .doc() -- [
            .text("1")-
        ]
        
        let mods = initialTree.diff(with: updatedTree)
        
        let mod1 = TreeMod<Element<String>>(
            path: [],
            value: .doc(),
            added: [],
            removed: ["1"]
        )
        
        XCTAssert(mods.first == mod1)
    }
    
    func test_diff5() {
        
        let mods: [TreeMod<Element<String>>] = diff(
            old: .doc() -- [
                .text("l1")-
            ],
            new: .doc() -- [
                .text("l1-changed")-
            ]
        )
        
        let em = TreeMod<Element<String>>(path: ["0"], value: .text("l1-changed"), added: [], removed: [])
        
        XCTAssert(mods == [em])
    }
    
    func test_diffNone() {
        
        let mods: [TreeMod<Element<String>>] = diff(
            old: .list()-,
            new: .list()-
        )
        
        XCTAssert(mods.isEmpty)
    }
    
    func test_diffTwo() {
        
        let l1: Tree<Element<String>> = .list() -- [
            .text("l1")-
        ]
        
        let l2: Tree<Element<String>> = .list() -- [
            .text("l2")-
        ]
        
        let l1_changed: Tree<Element<String>> = .list() -- [
            .text("l1-changed")-
        ]
        
        let l2_changed: Tree<Element<String>> = .list() -- [
            .text("l2-changed")-
        ]
        
        let mods = diff(
            old: .doc() -- [
                l1,
                l2
            ],
            new: .doc() -- [
                l1_changed,
                l2_changed
            ]
        )
        
        XCTAssert(mods.count == 2)
    }
}
