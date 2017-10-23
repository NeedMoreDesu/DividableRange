//
//  DividableRange.swift
//  DividableRange
//
//  Created by Oleksii Horishnii on 10/23/17.
//

import Foundation

public class DividableRange<Type> {
    public class Divider {
        public let idx: Int
        public let changeRightFn: ((Type) -> Type)
        public init(idx: Int, changeRightFn: @escaping ((Type) -> Type)) {
            self.idx = idx
            self.changeRightFn = changeRightFn
        }
    }
    
    private var next: DividableRange<Type>?
    
    private var left: Int?
    private var rightBound: Int?
    public var value: Type
    
    private init(_ value: Type) {
        self.value = value
    }
    
    private func isIndexInsideRange(idx: Int) -> Bool {
        return idx < (rightBound ?? Int.max) && idx >= (left ?? Int.min)
    }
    
    private func divideInIndex(idx: Int) -> DividableRange<Type> {
        assert(isIndexInsideRange(idx: idx))
        if self.left == idx {
            return self
        }
        
        let rightRange = DividableRange(self.value)
        
        rightRange.value = self.value
        rightRange.left = idx
        rightRange.rightBound = self.rightBound
        rightRange.next = self.next
        
        self.rightBound = idx
        self.next = rightRange
        
        return rightRange
    }
    
    private func findRangeForIndex(idx: Int) -> DividableRange<Type> {
        if self.isIndexInsideRange(idx: idx) {
            return self
        } else {
            return self.next!.findRangeForIndex(idx: idx)
        }
    }
    
    private func asArray() -> [DividableRange<Type>] {
        var arr: [DividableRange<Type>] = []
        var item: DividableRange<Type>? = self
        while item != nil {
            arr.append(item!)
            item = item!.next
        }
        return arr
    }
    
    private func changesAtSortedIndexes(arr: [Divider]) {
        var currentRange: DividableRange<Type> = self
        for divider in arr {
            let idx = divider.idx
            currentRange = currentRange.findRangeForIndex(idx: idx)
            currentRange = currentRange.divideInIndex(idx: idx)
            currentRange.value = divider.changeRightFn(currentRange.value)
        }
    }
    
    private func changesAtIndexes(arr: [Divider]) {
        let newArr = arr.sorted { (item1, item2) -> Bool in
            return item1.idx < item2.idx
        }
        return changesAtSortedIndexes(arr: newArr)
    }
    
    public class func rangesFor(baseValue: Type, changes: [Divider]) -> [DividableRange<Type>] {
        let range = DividableRange<Type>(baseValue)
        range.changesAtIndexes(arr: changes)
        return range.asArray()
    }
    
    public class func binarySearch(idx: Int, ranges: [DividableRange<Type>]) -> Type {
        return binarySearchInternal(idx: idx, ranges: ranges, left: 0, right: ranges.count).value
    }
    
    private class func binarySearchInternal(idx: Int, ranges: [DividableRange<Type>], left: Int, right: Int) -> DividableRange<Type> {
        let middlepoint = (left+right)/2
        let middlerange = ranges[middlepoint]
        if (middlerange.isIndexInsideRange(idx: idx)) {
            return middlerange
        } else if (idx < (middlerange.left ?? Int.min)) {
            return binarySearchInternal(idx: idx, ranges: ranges, left: left, right: middlepoint)
        } else {
            return binarySearchInternal(idx: idx, ranges: ranges, left: middlepoint, right: right)
        }
    }
}
