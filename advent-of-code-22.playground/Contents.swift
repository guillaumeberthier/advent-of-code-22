import UIKit

// MARK: - Day 1

print("*** Day 1")
let foodManager = FoodManager(fileLoader: TxtFileLoader())
print(try foodManager.maxFoodSum(input: "day-1", nFirst: 1))
print(try foodManager.maxFoodSum(input: "day-1", nFirst: 3))

// MARK: - Day 2

print("*** Day 2")
let tournament = RockPaperScissorsTournament(fileLoader: TxtFileLoader())
print(try tournament.getScore(input: "day-2", part: .one))
print(try tournament.getScore(input: "day-2", part: .two))

// MARK: - Day 3

print("*** Day 3")
let rucksack = RucksackManager(fileLoader: TxtFileLoader())
print(try rucksack.getPrioScoreHalf(input: "day-3"))
print(try rucksack.getPrioScoreTriplet(input: "day-3"))
