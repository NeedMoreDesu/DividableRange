// https://github.com/Quick/Quick

import Quick
import Nimble
import DividableRange

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("something something") {
            let ranges = DividableRange<Int>.rangesFor(baseValue: 0, changes: [
                DividableRange<Int>.Divider(idx: 50, changeRightFn: { $0 + 9000 }),
                DividableRange<Int>.Divider(idx: 4, changeRightFn: { $0 + 1 }),
                DividableRange<Int>.Divider(idx: 7, changeRightFn: { $0 + 1 }),
                DividableRange<Int>.Divider(idx: 10, changeRightFn: { $0 - 1 }),
                DividableRange<Int>.Divider(idx: 20, changeRightFn: { $0 + 100 }),
                DividableRange<Int>.Divider(idx: 13, changeRightFn: { $0 + 1 }),
                DividableRange<Int>.Divider(idx: 20, changeRightFn: { $0 + 10 }),
                ])
            
            it("<4 be 0") {
                expect(DividableRange<Int>.binarySearch(idx: 3, ranges: ranges)) == 0
                expect(DividableRange<Int>.binarySearch(idx: 0, ranges: ranges)) == 0
            }

            it("4-6 be 1") {
                expect(DividableRange<Int>.binarySearch(idx: 4, ranges: ranges)) == 1
                expect(DividableRange<Int>.binarySearch(idx: 6, ranges: ranges)) == 1
            }
            
            it("7-9 be 2") {
                expect(DividableRange<Int>.binarySearch(idx: 7, ranges: ranges)) == 2
                expect(DividableRange<Int>.binarySearch(idx: 9, ranges: ranges)) == 2
            }
            
            it("10-12 be 1") {
                expect(DividableRange<Int>.binarySearch(idx: 10, ranges: ranges)) == 1
                expect(DividableRange<Int>.binarySearch(idx: 12, ranges: ranges)) == 1
            }

            it("13-19 be 2") {
                expect(DividableRange<Int>.binarySearch(idx: 13, ranges: ranges)) == 2
                expect(DividableRange<Int>.binarySearch(idx: 14, ranges: ranges)) == 2
                expect(DividableRange<Int>.binarySearch(idx: 19, ranges: ranges)) == 2
            }

            it("20-50 be 112") {
                expect(DividableRange<Int>.binarySearch(idx: 20, ranges: ranges)) == 112
                expect(DividableRange<Int>.binarySearch(idx: 30, ranges: ranges)) == 112
                expect(DividableRange<Int>.binarySearch(idx: 49, ranges: ranges)) == 112
            }
            
            it("50+ be 9112") {
                expect(DividableRange<Int>.binarySearch(idx: 50, ranges: ranges)) == 9112
                expect(DividableRange<Int>.binarySearch(idx: 100, ranges: ranges)) == 9112
                expect(DividableRange<Int>.binarySearch(idx: 9999, ranges: ranges)) == 9112
            }
        }
    }
}
