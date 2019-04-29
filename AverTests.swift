import XCTest
@testable import AverLib

class AverTests: XCTestCase {
    
    let doc = MarkDownElements().doc
    let list = MarkDownElements().list
    let newLine = MarkDownElements().newLine
    let text = MarkDownElements().text

    func test1() {
        
        let aver = Aver<String>()
        
        let r = aver.render(doc() -- [text("foo")-])
        
        XCTAssert(r == "foo")
        
        let tr = doc() -- [
            list() -- [
                text("foo")-,
                text("bar")-
            ],
            newLine()-,
            text("quz")-
        ]
        
        XCTAssert(aver.render(tr) == "- foo\n- bar\n\n\nquz")
    }

}
