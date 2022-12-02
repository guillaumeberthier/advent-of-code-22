import Foundation

public protocol FileLoader {
  func get(input: String) throws -> String
}

public struct TxtFileLoader: FileLoader {
  public init() {}
  
  public func get(input: String) throws -> String {
    let fileURL = Bundle.main.url(forResource: input, withExtension: "txt")
    let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
    return content
  }
}
