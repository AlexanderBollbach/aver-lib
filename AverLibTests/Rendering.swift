import XCTest
@testable import AverLib

class RenderingTests: XCTestCase {
    
//    func testRender1() {
//
//        let md = MarkDownElements()
//
//        let aver = Aver<String>()
//
//        let t1 = md.doc() -- [
//            md.list() -- [
//                md.text("1")-,
//                md.text("2")-
//            ],
//            md.list() -- [
//                md.text("3")-,
//                md.text("4")-
//            ],
//            md.newLine()-,
//            md.text("paragraph")-
//        ]
//
//        let r = aver.render(t1)
//
//        print(r)
//    }
    
    func testResolve3() {
//        
//        let diff = Diffing<Element<String>>().standard
//        let resolve = Resolving<String>().standard
//        
//        let md = MarkDownElements()
//        
//        var initialTree = md.doc() -- [
//            md.list() -- [
//                md.text("1")-,
//                md.list() -- [
//                    md.text("1")-
//                ]
//            ],
//            md.text("still-cached")-
//        ]
//        
////        var r = initialTree.log()
////        print(r)
//        
////        initialTree.render()
//        
////        r = initialTree.log()
////        print(r)
//        
//        let updatedTree = md.doc() -- [
//            md.list() -- [
//                md.text("1")-,
//                md.list() -- [
//                    md.text("1-changed")-
//                ]
//            ],
//            md.text("still-cached")-
//        ]
//
//        let mods = diff(initialTree, updatedTree)
//        let resolvedTree = resolve(initialTree, mods)
//        
//        r = resolvedTree.log()
//        print(r)
//
//        // check mods
//        let newTree = md.list() -- [md.text("1")-, md.text("2")-]
//        let expected = TreeMod(path: ["0"], tree: newTree)
//        XCTAssert(mods.first == expected)
//
//        let result = resolve(initialTree, mods)
//        XCTAssert(result == updatedTree)
//
//        //        updatedTree.render()
//
//        print(updatedTree.debugLog)
        
    }
}
