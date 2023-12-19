import Foundation

enum Alefbet: String {
  case alef = "א"
  case bet = "ב"
  case gimel = "ג"
  case dalet = "ד"
  case he = "ה"
  case vav = "ו"
  case zayin = "ז"
  case chet = "ח"
  case tet = "ט"
  case yod = "י"
  case kaf = "כ"
  case kafSofit = "ך"
  case lamed = "ל"
  case mem = "מ"
  case memSofit = "ם"
  case nun = "נ"
  case nunSofit = "ן"
  case samekh = "ס"
  case ayin = "ע"
  case pe = "פ"
  case peSofit = "ף"
  case tsadi = "צ"
  case tsadiSofit = "ץ"
  case qof = "ק"
  case resh = "ר"
  case shin = "ש\u{05C1}"
  case sin = "ש\u{05C2}"
  case sinWithoutDot = "ש"
  case tav = "ת"
}

extension Alefbet: CaseIterable {}
extension Alefbet: CustomStringConvertible {
  var description: String { self.rawValue }
}

extension Alefbet {
  static var begadkefath: Set<Alefbet> {
    [
      .bet,
      .gimel,
      .dalet,
      .kaf,
      .pe,
      .tav,
    ]
  }
}

extension Alefbet {
  static var sofit: Set<Alefbet> {
    [
      .kafSofit,
      .memSofit,
      .nunSofit,
      .peSofit,
      .tsadiSofit,
    ]
  }
}
