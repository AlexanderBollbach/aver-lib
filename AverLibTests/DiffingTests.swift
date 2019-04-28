import XCTest
@testable import AverLib

class DiffingTests: XCTestCase {
    
    func test_diff1() {
        
        let diff = Diffing<Element<String>>().standard
        let md = MarkDownElements.init()
        
        let initialTree = md.doc() -- [
            md.list() -- [
                md.text("1")-
            ],
            md.text("still-cached")-
        ]
        
        let updatedTree = md.doc() -- [
            md.list() -- [
                md.text("1")-,
                md.text("added")-
            ],
            md.text("still-cached")-
        ]
        
        let mods = diff(initialTree, updatedTree)
        
        XCTAssert(mods.count == 1)
        
        let expectedMod = TreeMod(
            path: ["0"],
            value: md.list(),
            added: [(md.text("added")-).withKey(key: "1")],
            removed: []
        )
        
        XCTAssert(mods.first == expectedMod)
    }
    
    func test_diff2() {
        
        let diff = Diffing<Element<String>>().standard
        let md = MarkDownElements.init()
        
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
        
        let mods = diff(initialTree, updatedTree)
        
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
    
    func test_diff4() {
        
        let diff = Diffing<Element<String>>().standard
        let resolve = Resolving<String>().standard
        let md = MarkDownElements.init()
        
        let initialTree = md.doc() -- [
            md.list() -- [
                md.text("1")-
            ],
            md.text("still-cached")-
        ]

        let updatedTree = md.doc() -- [
            md.list() -- [
                md.text("1")-,
                md.text("added")-
            ],
            md.text("still-cached")-
        ]
        
        let mods = diff(initialTree, updatedTree)
        
        let r = resolve(initialTree, mods)
        
        print(updatedTree.log())
        print(r.log())
        
        XCTAssert(updatedTree == r)
    }

//    func test_diff1() {
//        
//        let diff = Diffing<Element<String>>().standard
//        
//        let md = MarkDownElements()
//        
//        let t1: Tree<Element<String>> = {
//            md.doc() -- [
//                md.text("l1")-
//            ]
//        }()
//        
//        let t2: Tree<Element<String>> = {
//            md.doc() -- [
//                md.text("l1-changed")-
//            ]
//        }()
//        
//        let mods = diff(t1, t2)
//        
//        XCTAssert(mods.count == 1)
//    }
//    
//    func test_diffNone() {
//        
//        let diff = Diffing<Element<String>>().standard
//        
//        let md = MarkDownElements()
//        
//        let oldList = md.list() -- [
//            md.text("l1")-,
//            md.text("l2")-
//        ]
//        
//        let t1: Tree<Element<String>> = {
//            md.doc() -- [
//                md.text("2")-,
//                oldList
//            ]
//        }()
//        
//        let t2: Tree<Element<String>> = {
//            md.doc() -- [
//                md.text("2")-,
//                oldList
//            ]
//        }()
//
//        XCTAssert(diff(t1, t2).isEmpty)
//    }
//    
//    func test_diffTwo() {
//        
//        let diff = Diffing<Element<String>>().standard
//        
//        let md = MarkDownElements()
//        
//        let l1 = md.list() -- [
//            md.text("l1")-
//        ]
//        
//        let l2 = md.list() -- [
//            md.text("l2")-
//        ]
//        
//        let l1_changed = md.list() -- [
//            md.text("l1-changed")-
//        ]
//        
//        let l2_changed = md.list() -- [
//            md.text("l2-changed")-
//        ]
//       
//        let t1: Tree<Element<String>> = {
//            md.doc() -- [
//                l1,
//                l2
//            ]
//        }()
//        
//        let t2: Tree<Element<String>> = {
//            md.doc() -- [
//                l1_changed,
//                l2_changed
//            ]
//        }()
//        
//        let mods = diff(t1, t2)
//        
//        XCTAssert(mods.count == 2)
//    }
}
