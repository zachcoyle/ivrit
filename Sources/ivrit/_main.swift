import ArgumentParser
import IvritKit

@main
struct Ivrit: ParsableCommand {
  static var configuration = CommandConfiguration(
    abstract: "a tool to process Hebrew text",
    subcommands: [
      Ivrit.Remove.self
    ]
  )
  struct Options: ParsableArguments {

  }
}

enum NiqqudType: String, ExpressibleByArgument {
  case all
  case none
  case accents
  case vowels
  case nonVowelPoints
  case points
  case punctuation
  case marks
}

func niqqudimForArg(_ nt: NiqqudType) -> Set<Niqqud> {
  switch nt {
  case .all:
    Niqqud.all
  case .none:
    Niqqud.none
  case .accents:
    Niqqud.accents
  case .vowels:
    Niqqud.vowels
  case .nonVowelPoints:
    Niqqud.nonVowelPoints
  case .points:
    Niqqud.points
  case .punctuation:
    Niqqud.punctuation
  case .marks:
    Niqqud.marks
  }
}

extension Niqqud: ExpressibleByArgument {}

extension Ivrit {
  struct Remove: ParsableCommand {
    static var configuration = CommandConfiguration(
      abstract: "Remove Niqqud from a given string"
    )

    @Option(name: .shortAndLong, parsing: .next)
    var type: NiqqudType = .none

    @Option(name: .shortAndLong, help: "Text to Process")
    var text = ""
  }
}
