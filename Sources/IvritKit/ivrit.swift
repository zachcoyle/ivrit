import Foundation

public func remove(text: String, options: Set<Niqqud>) -> String {
  guard options != [] else { return text }
  return String(
    text
      .unicodeScalars
      .filter {
        !options.flatMap { $0.rawValue.unicodeScalars }
          .contains($0)
      }
  )
}

public func remove(text: String, options: [Niqqud]) -> String {
  remove(text: text, options: Set(options))
}

public func remove(text: String, options: Niqqud) -> String {
  remove(text: text, options: [options])
}
