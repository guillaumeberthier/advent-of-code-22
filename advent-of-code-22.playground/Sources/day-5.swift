import Foundation

public struct SupplyStack {

  private let fileLoader: FileLoader

  public init(fileLoader: FileLoader) {
    self.fileLoader = fileLoader
  }

  public func getTopStack9000(input: String) throws -> String {
    let out = try fileLoader.get(input: input)
      .split(separator: "\n\n")
      .map { $0.split(separator: "\n") }
    let actions = out[1]
    var stacks = getStacks()
    for action in actions {
      let move = try getMove(line: String(action))
      for _ in 0..<move.0 {
        let supply = stacks[move.1-1].removeLast()
        stacks[move.2-1].append(supply)
      }
    }
    return stacks
      .map { $0.last ?? "" }
      .joined(separator: "")
  }

  public func getTopStack9001(input: String) throws -> String {
    let out = try fileLoader.get(input: input)
      .split(separator: "\n\n")
      .map { $0.split(separator: "\n") }
    let actions = out[1]
    var stacks = getStacks()
    for action in actions {
      let move = try getMove(line: String(action))
      let supplies = stacks[move.1-1].suffix(move.0)
      stacks[move.1-1].removeLast(move.0)
      stacks[move.2-1].append(contentsOf: supplies)
    }
    return stacks
      .map { $0.last ?? "" }
      .joined(separator: "")
  }

  private func getMove(line: String) throws -> (Int, Int, Int) {
    let search = /move (?<count>\d+) from (?<from>\d+) to (?<to>\d+)/
    if let result = try? search.wholeMatch(in: line) {
      let a = Int(result.count)!
      let b = Int(result.from)!
      let c = Int(result.to)!
      return (a, b, c)
    } else {
      throw MyError.failToMapMove
    }
  }

  private func getStacksExample() -> [[String]] {
    [
      ["Z", "N"],
      ["M", "C", "D"],
      ["P"],
    ]
  }

  private func getStacks() -> [[String]] {
    [
      ["B", "G", "S", "C"],
      ["T", "M", "W", "H", "J", "N", "V", "G"],
      ["M", "Q", "S"],
      ["B", "S", "L", "T", "W", "N", "M"],
      ["J", "Z", "F", "T", "V", "G", "W", "P"],
      ["C", "T", "B", "G", "Q", "H", "S"],
      ["T", "J", "P", "B", "W"],
      ["G", "D", "C", "Z", "F", "T", "Q", "M"],
      ["N", "S", "H", "B", "P", "F"]
    ]
  }

  private enum MyError: Error {
    case failToMapMove
  }
}
