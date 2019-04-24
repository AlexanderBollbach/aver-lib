import XCTest
@testable import AverLib

class DiffingTests: XCTestCase {

    func test_diff1() {
        
        let diff = Diffing<Element<String>>().standard
        
        let md = MarkDownElements()
        
        let t1: Tree<Element<String>> = {
            md.doc() -- [
                md.text("l1")-
            ]
        }()
        
        let t2: Tree<Element<String>> = {
            md.doc() -- [
                md.text("l1-changed")-
            ]
        }()
        
        let mods = diff(t1, t2)
        
        XCTAssert(mods.count == 1)
    }
    
    func test_diffNone() {
        
        let diff = Diffing<Element<String>>().standard
        
        let md = MarkDownElements()
        
        let oldList = md.list() -- [
            md.text("l1")-,
            md.text("l2")-
        ]
        
        let t1: Tree<Element<String>> = {
            md.doc() -- [
                md.text("2")-,
                oldList
            ]
        }()
        
        let t2: Tree<Element<String>> = {
            md.doc() -- [
                md.text("2")-,
                oldList
            ]
        }()

        XCTAssert(diff(t1, t2).isEmpty)
    }
    
    func test_diffTwo() {
        
        let diff = Diffing<Element<String>>().standard
        
        let md = MarkDownElements()
        
        let l1 = md.list() -- [
            md.text("l1")-
        ]
        
        let l2 = md.list() -- [
            md.text("l2")-
        ]
        
        let l1_changed = md.list() -- [
            md.text("l1-changed")-
        ]
        
        let l2_changed = md.list() -- [
            md.text("l2-changed")-
        ]
       
        let t1: Tree<Element<String>> = {
            md.doc() -- [
                l1,
                l2
            ]
        }()
        
        let t2: Tree<Element<String>> = {
            md.doc() -- [
                l1_changed,
                l2_changed
            ]
        }()
        
        let mods = diff(t1, t2)
        
        XCTAssert(mods.count == 2)
    }
}
