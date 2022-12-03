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

extension Array {
  func splitGrouped(n: Int) -> [[Element]] {
    var groups: [[Element]] = []
    var group: [Element] = []
    var l = n
    for line in self {
      group.append(line)
      l -= 1
      if l == 0 {
        groups.append(group)
        group = []
        l = n
      }
    }
    return groups
  }
}
