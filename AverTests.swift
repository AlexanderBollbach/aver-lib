import XCTest
@testable import AverLib

class AverTests: XCTestCase {
    
    func test1() {
        
        let aver = Aver<String>()
        
        let r = aver.render(.doc() -- [.text("foo")-])
        
        XCTAssert(r == "foo")
        
        let tr = .doc() -- [
            .list() -- [
                .text("foo")-,
                .text("bar")-
            ],
            .newLine()-,
            .text("quz")-
        ]
        
        XCTAssert(aver.render(tr) == "- foo\n- bar\n\n\nquz")
    }

}
