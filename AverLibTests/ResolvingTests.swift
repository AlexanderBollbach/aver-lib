import XCTest
@testable import AverLib

class ResolvingTests: XCTestCase {
    
//    func testResolve1() {
//
//        let diff = Diffing<Element<String>>().standard
//
//        let resolve = Resolving<String>().standard
//
//        let md = MarkDownElements()
//
//        let trees: [Tree<Element<String>>] = [
//            md.doc() -- [
//                md.text("2")-
//            ],
//            md.doc() -- [
//                md.text("2-changed")-
//            ]
//        ]
//
//        let mods = diff(trees[0], trees[1])
//
//        let newTree = md.doc() -- [md.text("2-changed")- ]
//
//        let expected = TreeMod<Element<String>>(path: [], tree: newTree)
//
//        XCTAssert(mods.first == expected)
//
//        let initialTree = trees[0]
//        let finalTree = trees[1]
//
//        let result = resolve(initialTree, mods)
//
//        XCTAssert(result == finalTree)
//
//    }
//
//    func testResolve2() {
//
//        let diff = Diffing<String>().standard
//        let resolve = Resolving<String>().standard
//
//        let md = MarkDownElements()
//
//        let trees: [Tree<Element<String>>] = [
//            md.doc() -- [
//                md.text("2")-
//            ],
//            md.doc()-
//        ]
//
//        let mods = diff(trees[0], trees[1])
//
//        let newTree = md.doc()-
//
//        let expected = TreeMod<Element<String>>(path: [], tree: newTree)
//
//        XCTAssert(mods.first == expected)
//
//        let initialTree = trees[0]
//        let finalTree = trees[1]
//
//        let result = resolve(initialTree, mods)
//
//        XCTAssert(result == finalTree)
//
//    }
//
//    func testResolve3() {
//
//        let diff = Diffing<Element<String>>().standard
//        let resolve = Resolving<String>().standard
//        
//        let md = MarkDownElements()
//        
//        let initialTree = md.doc() -- [
//            md.list() -- [
//                md.text("1")-
//            ],
//            md.text("foo")-
//        ]
//        
//        let updatedTree = md.doc() -- [
//            md.list() -- [
//                md.text("1")-,
//                md.text("2")-
//            ],
//            md.text("foo")-
//        ]
//        
//        let mods = diff(initialTree, updatedTree)
//        
//        // check mods
//        let newTree = md.list() -- [md.text("1")-, md.text("2")-]
//        let expected = TreeMod(path: ["0"], tree: newTree)
//        XCTAssert(mods.first == expected)
//        
//        let result = resolve(initialTree, mods)
//        XCTAssert(result == updatedTree)
//        
////        updatedTree.render()
//        
//        print(updatedTree.debugLog)
//        
//    }
}
