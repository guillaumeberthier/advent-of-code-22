import Foundation

public struct RucksackManager {

  private let fileLoader: FileLoader

  public init(fileLoader: FileLoader) {
    self.fileLoader = fileLoader
  }

  public func getPrioScoreHalf(input: String) throws -> Int {
    let input = try fileLoader.get(input: input)
      .split(separator: "\n")
    let halves = input.map { [String($0.prefix($0.count / 2)), String($0.suffix($0.count / 2))] }
    return try halves
      .map { try getCommon(groups: $0) }
      .map { try getScore(char: $0) }
      .sum()
  }

  public func getPrioScoreTriplet(input: String) throws -> Int {
    try fileLoader.get(input: input)
      .split(separator: "\n")
      .map { String($0) }
      .splitGrouped(n: 3)
      .map { try getCommon(groups: $0) }
      .map { try getScore(char: $0) }
      .sum()
  }

  // MARK: - Private

  private func getCommon(groups: [String]) throws -> Character {
    for l in groups[0] {
      var contains = true
      for other in groups.suffix(from: 1) {
        if !other.contains(l) {
          contains = false
        }
      }
      if contains {
        return l
      }
    }
    throw MyError.noDoublon
  }

  private func getScore(char: Character) throws -> Int {
    let offset = char.isUppercase ? 38 : 96
    if let ascii = char.asciiValue {
      return Int(ascii) - offset
    } else {
      throw MyError.noAscii
    }
  }

  enum MyError: Error {
    case noDoublon
    case noAscii
  }
}
