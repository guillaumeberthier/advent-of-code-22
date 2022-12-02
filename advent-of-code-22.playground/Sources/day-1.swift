import Foundation

public struct FoodManager {

  private let fileLoader: FileLoader

  public init(fileLoader: FileLoader) {
    self.fileLoader = fileLoader
  }

  public func maxFoodSum(input: String, nFirst: Int) throws -> Int {
    try fileLoader.get(input: input)
      .split(separator: "\n\n")
      .map { $0
        .split(separator: "\n")
        .map { Int($0)! }
      }
      .map { $0.sum() }
      .sortedDescending()
      .prefix(nFirst)
      .sum()
  }
}
