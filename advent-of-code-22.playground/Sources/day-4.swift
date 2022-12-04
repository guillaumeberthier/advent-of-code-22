import Foundation

public struct CampCleanup {

  public enum Part {
    case one, two
  }

  private let fileLoader: FileLoader

  public init(fileLoader: FileLoader) {
    self.fileLoader = fileLoader
  }

  public func getOverlapCount(input: String, part: Part) throws -> Int {
    let pairs = try fileLoader.get(input: input)
      .split(separator: "\n")
      .map { $0
        .split(separator: ",")
        .map { $0
          .split(separator: "-")
          .map { Int($0)! }
        }
        .map { $0[0]...$0[1] }
      }
    let containedRange = pairs
      .map {
        switch part {
        case .one:
          return isContained(left: $0[0], right: $0[1])
        case .two:
          return isOverlaped(left: $0[0], right: $0[1])
        }
      }
      .filter { $0 }
      .count
    return containedRange
  }

  private func isContained(left: ClosedRange<Int>, right: ClosedRange<Int>) -> Bool {
    let smallRange = left.count < right.count ? left : right
    let otherRange = left.count < right.count ? right : left
    for s in smallRange {
      if false == otherRange.contains(s) {
        return false
      }
    }
    return true
  }

  private func isOverlaped(left: ClosedRange<Int>, right: ClosedRange<Int>) -> Bool {
    for l in left {
      if right.contains(l) {
        return true
      }
    }
    return false
  }
}
