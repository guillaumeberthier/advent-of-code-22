import Foundation

private enum Constant {
  // Part 1
  static let shapeToScore = [
    "X": 1,
    "Y": 2,
    "Z": 3
  ]
  static let wins = ["A Y", "B Z", "C X"]
  static let draws = ["A X", "B Y", "C Z"]

  // Part 2
  static let scoreByMove2 = [
    "X": 0,
    "Y": 3,
    "Z": 6
  ]
  static let scoreByShape2 = [
    "A": 1,
    "B": 2,
    "C": 3
  ]
  static let movesToLose2 = ["C", "A", "B"]
  static let moves2 =       ["A", "B", "C"]
  static let movesToWin2 =  ["B", "C", "A"]
}

public struct RockPaperScissorsTournament {

  public enum Part {
    case one, two
  }

  private let fileLoader: FileLoader

  public init(fileLoader: FileLoader) {
    self.fileLoader = fileLoader
  }

  public func getScore(input: String, part: Part) throws -> Int {
    try fileLoader.get(input: input)
      .split(separator: "\n")
      .map {
        switch part {
          case .one: return getScore1(line: String($0))
          case .two: return getScore2(line: String($0))
        }
      }
      .sum()
  }

  // MARK: - Private

  private func getScore1(line: String) -> Int {
    let myMoveScore = Constant.shapeToScore["\(line.split(separator: " ")[1])"]!
    if Constant.wins.contains(line) {
      return 6 + myMoveScore
    } else if Constant.draws.contains(line) {
      return 3 + myMoveScore
    } else {
      return 0 + myMoveScore
    }
  }

  private func getScore2(line: String) -> Int {
    let split = line.split(separator: " ")
    let vilainMove = "\(split[0])"
    let indexVilainMove = Constant.moves2.firstIndex(of: vilainMove)!
    let outcome = "\(split[1])"
    let theMoveIShouldDo: String
    if outcome == "X" { // Lose
      theMoveIShouldDo = Constant.movesToLose2[indexVilainMove]
    } else if outcome == "Y" { // Draw
      theMoveIShouldDo = Constant.moves2[indexVilainMove]
    } else { // Win
      theMoveIShouldDo = Constant.movesToWin2[indexVilainMove]
    }
    let myMoveScore = Constant.scoreByShape2[theMoveIShouldDo]!
    let outcomeScore = Constant.scoreByMove2[outcome]!
    return myMoveScore + outcomeScore
  }
}
