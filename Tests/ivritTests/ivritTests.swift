import Algorithms
import SwiftCheck
import XCTest

@testable import ivrit

extension Alefbet: Arbitrary {
  public static var arbitrary: SwiftCheck.Gen<ivrit.Alefbet> {
    Gen.fromElements(of: Alefbet.allCases)
  }
}

extension Niqqud: Arbitrary {
  public static var arbitrary: SwiftCheck.Gen<ivrit.Niqqud> {
    Gen.fromElements(of: Niqqud.allCases)
  }
}

let gen_1_1 = "בְּרֵאשִׁ֖ית בָּרָ֣א אֱלֹהִ֑ים אֵ֥ת הַשָּׁמַ֖יִם וְאֵ֥ת הָאָֽרֶץ׃"
let gen11Letters: [Alefbet] = [
  .bet,
  .resh,
  .alef,
  .sinWithoutDot,
  .yod,
  .lamed,
  .he,
  .memSofit,
  .tav,
  .mem,
  .vav,
  .tsadiSofit,
]

let and = { $0 && $1 }

final class ivritTests: XCTestCase {

  func testConstantMinusVowel() throws {
    property("Consonant == Consonant - Vowel")
      <- forAll { (x: Alefbet) in
        x.rawValue == remove(text: x.rawValue, options: Niqqud.vowels)
      }
  }

  func testConstantMinusNonVowelPoint() throws {
    property("Non-Shin Consonant == Consonant - Non-Vowel Points")
      <- forAll { (x: Alefbet) in
        switch x {
        case .shin:
          x.rawValue != remove(text: x.rawValue, options: Niqqud.nonVowelPoints)
        case .sin:
          x.rawValue != remove(text: x.rawValue, options: Niqqud.nonVowelPoints)
        default:
          x.rawValue == remove(text: x.rawValue, options: Niqqud.nonVowelPoints)
        }
      }
  }

  func testConstantMinusPoint() throws {
    property("Non-Shin Consonant == Consonant - Points")
      <- forAll { (x: Alefbet) in
        switch x {
        case .shin:
          x.rawValue != remove(text: x.rawValue, options: Niqqud.points)
        case .sin:
          x.rawValue != remove(text: x.rawValue, options: Niqqud.points)
        default:
          x.rawValue == remove(text: x.rawValue, options: Niqqud.points)
        }
      }
  }

  @available(iOS 16.0, *)
  func testGen_1_1_Remove() throws {
    property("Gen 1:1 Never Loses Consonants")
      <- forAll { (xs: Set<Niqqud>) in
        let removed = remove(text: gen_1_1, options: xs)
        return gen11Letters.map {
          removed.unicodeScalars.contains($0.rawValue.unicodeScalars)
        }.reduce(true, and)
      }
  }

  func testInterspersed() throws {
    property("Consonants interspersed with any Niqqud - Niqqud = Original Consonants")
      <- forAll { (xs: [Alefbet], ys: Set<Niqqud>) in
        let noSinShinWithDot = xs.filter { $0 != .sin && $0 != .shin }
        let xsJoined = noSinShinWithDot.map { $0.rawValue }.joined()
        return ys.map {
          noSinShinWithDot.map { $0.rawValue }.interspersed(with: $0.rawValue).joined()
        }
        .map { remove(text: $0, options: ys) }
        .reduce(true, { $0 && xsJoined == $1 })
      }
  }
}
