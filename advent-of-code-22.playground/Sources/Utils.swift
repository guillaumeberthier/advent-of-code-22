import Foundation

extension Array where Element == Int {
  func sum() -> Int {
    self.reduce(0, { $0 + $1 })
  }

  func sortedDescending() -> [Int] {
    self.sorted(by: { $0 > $1 })
  }
}

extension ArraySlice where Element == Int {
  func sum() -> Int {
    self.reduce(0, { $0 + $1 })
  }

  func sortedDescending() -> [Int] {
    self.sorted(by: { $0 > $1 })
  }
}
