import Algorithms
import SwiftCheck
import XCTest

@testable import IvritKit

extension Alefbet: Arbitrary {
  public static var arbitrary: SwiftCheck.Gen<IvritKit.Alefbet> {
    Gen.fromElements(of: Alefbet.allCases)
  }
}

extension Niqqud: Arbitrary {
  public static var arbitrary: SwiftCheck.Gen<IvritKit.Niqqud> {
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
  func testGen1_1KeepsConsonants() throws {
    property("Gen 1:1 Never Loses Consonants")
      <- forAll { (xs: Set<Niqqud>) in
        let removed = remove(text: gen_1_1, options: xs)
        return gen11Letters.map {
          removed.unicodeScalars.contains($0.rawValue.unicodeScalars)
        }.reduce(true, and)
      }
  }

  func testGen1_1RemoveAll() throws {
    let testText = "בראשית ברא אלהים את השמים ואת הארץ"
    XCTAssert(testText == remove(text: gen_1_1, options: Niqqud.all))
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

  func testNiqqudRemovesItself() throws {
    property("Niqqud - Itself = ''")
      <- forAll { (x: Niqqud) in
        "" == remove(text: x.rawValue, options: x)
      }
  }

  func testRemoveNone() throws {
    let testString = "שָׂרַ֣י אִשְׁתְּךָ֔, וַֽיִּמְצְא֗וּ"
    XCTAssert(testString == remove(text: testString, options: []))
  }

  func testRemoveAccents() throws {
    let testString = "שָׂרַ֣י אִשְׁתְּךָ֔, וַֽיִּמְצְא֗וּ"
    let expectedResult = "שָׂרַי אִשְׁתְּךָ, וַֽיִּמְצְאוּ"
    XCTAssert(expectedResult == remove(text: testString, options: Niqqud.accents))
  }

  func testRemoveAccentsVowelsLeaveSinShinDot() throws {
    let testString = "שָׂרַ֣י אִשְׁתְּךָ֔, וַֽיִּמְצְא֗וּ"
    let expectedResult = "שׂרי אשׁתך, וימצאו"
    let removed = remove(text: testString, options: Niqqud.accents + Niqqud.vowels + Niqqud.meteg)
    XCTAssert(expectedResult == removed)
  }

  func testRemoveAll() throws {
    let testString = "שָׂרַ֣י אִשְׁתְּךָ֔, וַֽיִּמְצְא֗וּ"
    let expectedResult = "שרי אשתך, וימצאו"
    let removed = remove(text: testString, options: Niqqud.allCases)
    XCTAssert(expectedResult == removed)
  }

  func testRemoveSinShinDot() throws {
    let testString = "שָׂרַ֣י אִשְׁתְּךָ֔"
    let expectedResult = "שָרַ֣י אִשְתְּךָ֔"
    let removed = remove(text: testString, options: [Niqqud.sinDot, Niqqud.shinDot])
    XCTAssert(expectedResult == removed)
  }

  func testAsciiIdentity() throws {
    for i in 0x0000...0x007F {
      if let u = UnicodeScalar(i) {
        let ascii = String(u)
        XCTAssert(ascii == remove(text: ascii, options: Niqqud.all))
      }
    }
  }

  func testAllUnicodeIdentityExceptNiqqud() throws {
    for i in 0x0000...0x10FFFD {
      if let scalar = UnicodeScalar(i) {
        let u = String(scalar)
        if let nq = Niqqud(rawValue: u) {
          print("Unicode Identity - Skipping \(nq)")
        } else {
          XCTAssert(u == remove(text: u, options: Niqqud.all))
        }
      }
    }
  }

  func testAllEmojiIdentity() throws {
    for i in 0x1F601...0x65039 {
      if let scalar = UnicodeScalar(i) {
        let emoji = String(scalar)
        XCTAssert(emoji == remove(text: emoji, options: Niqqud.all))
      }
    }
  }

}
