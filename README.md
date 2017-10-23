# DividableRange

[![Version](https://img.shields.io/cocoapods/v/DividableRange.svg?style=flat)](http://cocoapods.org/pods/DividableRange)
[![License](https://img.shields.io/cocoapods/l/DividableRange.svg?style=flat)](http://cocoapods.org/pods/DividableRange)
[![Platform](https://img.shields.io/cocoapods/p/DividableRange.svg?style=flat)](http://cocoapods.org/pods/DividableRange)

## Example

```swift
let ranges = DividableRange<Int>.rangesFor(baseValue: 0, changes: [
    DividableRange<Int>.Divider(idx: 24, changeRightFn: { $0 + 9000 }),
    DividableRange<Int>.Divider(idx: 4, changeRightFn: { $0 + 1 }),
    DividableRange<Int>.Divider(idx: 7, changeRightFn: { $0 + 1 }),
    DividableRange<Int>.Divider(idx: 10, changeRightFn: { $0 - 1 }),
    DividableRange<Int>.Divider(idx: 20, changeRightFn: { $0 + 100 }),
    DividableRange<Int>.Divider(idx: 13, changeRightFn: { $0 + 1 }),
    DividableRange<Int>.Divider(idx: 20, changeRightFn: { $0 + 10 }),
    ])

var someIndexes = Array(0..<25)
let itemsAtIndexes = someIndexes.map { (idx) -> Int in
   return DividableRange<Int>.binarySearch(idx: idx, ranges: ranges)
}
print(itemsAtIndexes) // [0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 112, 112, 112, 112, 9112]
```

## Complexity

Creation is O(N*log(N))

Lookup is O(log(N))

## Installation

DividableRange is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DividableRange'
```

## Author

Oleksii Horishnii, oleksii.horishnii@gmail.com

## License

DividableRange is available under the MIT license. See the LICENSE file for more info.
