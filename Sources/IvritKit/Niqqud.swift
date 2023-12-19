import Foundation

public enum Niqqud: String, CaseIterable {
  // accent
  case etnahta = "\u{0591}"
  case segolta = "\u{0592}"
  case shalshelet = "\u{0593}"
  case zaqefQatan = "\u{0594}"
  case zaqefGadol = "\u{0595}"
  case tipeha = "\u{0596}"
  case revia = "\u{0597}"
  case zarqa = "\u{0598}"
  case pashta = "\u{0599}"
  case yetiv = "\u{059A}"
  case tevir = "\u{059B}"
  case geresh = "\u{059c}"
  case gereshMuqdam = "\u{059D}"
  case gershayim = "\u{059E}"
  case qarneyPara = "\u{059F}"
  case telishaGedola = "\u{05A0}"
  case pazer = "\u{05A1}"
  case atnahHafukh = "\u{05A2}"
  case munah = "\u{05A3}"
  case mahapakh = "\u{05A4}"
  case merkha = "\u{05A5}"
  case merkhaKefula = "\u{05A6}"
  case darga = "\u{05A7}"
  case qadma = "\u{05A8}"
  case telishaQetana = "\u{05A9}"
  case yerahBenYomo = "\u{05AA}"
  case ole = "\u{05AB}"
  case iluy = "\u{05AC}"
  case dehi = "\u{05AD}"
  case zinor = "\u{05AE}"
  // vowel point
  case sheva = "\u{05B0}"
  case hatafSegol = "\u{05B1}"
  case hatafPatah = "\u{05B2}"
  case hatafQamats = "\u{05B3}"
  case hiriq = "\u{05B4}"
  case tsere = "\u{05B5}"
  case segol = "\u{05B6}"
  case patah = "\u{05B7}"
  case qamats = "\u{05B8}"
  case holam = "\u{05B9}"
  case holamHaserForVav = "\u{05BA}"
  case qubuts = "\u{05BB}"
  case dagesh = "\u{05BC}"
  case qamatsQatan = "\u{05C7}"
  // non-vowel point
  case meteg = "\u{05BD}"
  case rafe = "\u{05BF}"
  case shinDot = "\u{05C1}"
  case sinDot = "\u{05C2}"
  // punctuation
  case maqaf = "\u{05BE}"
  case paseq = "\u{05C0}"
  case sofPasuq = "\u{05C3}"
  case nunHafukha = "\u{05C6}"
  case puncGeresh = "\u{05F3}"
  case puncGershayim = "\u{05F4}"
  // mark
  case masoraCircle = "\u{05AF}"
  case upperDot = "\u{05C4}"
  case lowerDot = "\u{05C5}"
}

extension Niqqud {
  public static var all: Set<Niqqud> { Set(Niqqud.allCases) }
}

extension Niqqud {
  public static var none: Set<Niqqud> { [] }
}

extension Niqqud {
  public static var accents: Set<Niqqud> {
    [
      .etnahta,
      .segolta,
      .shalshelet,
      .zaqefQatan,
      .zaqefGadol,
      .tipeha,
      .revia,
      .zarqa,
      .pashta,
      .yetiv,
      .tevir,
      .geresh,
      .gereshMuqdam,
      .gershayim,
      .qarneyPara,
      .telishaGedola,
      .pazer,
      .atnahHafukh,
      .munah,
      .mahapakh,
      .merkha,
      .merkhaKefula,
      .darga,
      .qadma,
      .telishaQetana,
      .yerahBenYomo,
      .ole,
      .iluy,
      .dehi,
      .zinor,
    ]
  }
}

extension Niqqud {
  public static var vowels: Set<Niqqud> {
    [
      .sheva,
      .hatafSegol,
      .hatafPatah,
      .hatafQamats,
      .hiriq,
      .tsere,
      .segol,
      .patah,
      .qamats,
      .holam,
      .holamHaserForVav,
      .qubuts,
      .dagesh,
      .qamatsQatan,
    ]
  }
}

extension Niqqud {
  public static var nonVowelPoints: Set<Niqqud> {
    [
      .meteg,
      .rafe,
      .shinDot,
      .sinDot,
    ]
  }
}

extension Niqqud {
  public static var points: Set<Niqqud> {
    vowels.union(nonVowelPoints)
  }
}

extension Niqqud {
  public static var punctuation: Set<Niqqud> {
    [
      .maqaf,
      .paseq,
      .sofPasuq,
      .nunHafukha,
      .puncGeresh,
      .puncGershayim,
    ]
  }
}

extension Niqqud {
  public static var marks: Set<Niqqud> {
    [
      .masoraCircle,
      .upperDot,
      .lowerDot,
    ]
  }
}

extension Set<Niqqud> {
  public func with(_ xs: Set<Niqqud>) -> Set<Niqqud> {
    return self.union(xs)
  }
  public func with(_ x: Niqqud) -> Set<Niqqud> {
    return self.union([x])
  }
  public func without(_ xs: Set<Niqqud>) -> Set<Niqqud> {
    return self.filter { !xs.contains($0) }
  }
  public func without(_ x: Niqqud) -> Set<Niqqud> {
    return self.filter { $0 == x }
  }
}

extension Set<Niqqud> {
  public static func + (_ lhs: Set<Niqqud>, _ rhs: Set<Niqqud>) -> Set<Niqqud> {
    return lhs.union(rhs)
  }
  public static func + (_ lhs: Set<Niqqud>, _ rhs: Niqqud) -> Set<Niqqud> {
    return lhs.union([rhs])
  }
  public static func + (_ lhs: Niqqud, _ rhs: Set<Niqqud>) -> Set<Niqqud> {
    return rhs.union([lhs])
  }
}

extension Niqqud {
  public var pretty: String {
    switch self {
    case .etnahta:
      "Etnahta"
    case .segolta:
      "Segolta"
    case .shalshelet:
      "Shalshelet"
    case .zaqefQatan:
      "Zaqef Qatan"
    case .zaqefGadol:
      "Zaqef Gadol"
    case .tipeha:
      "Tipeha"
    case .revia:
      "Revia"
    case .zarqa:
      "Zarqa"
    case .pashta:
      "Pashta"
    case .yetiv:
      "Yetiv"
    case .tevir:
      "Tevir"
    case .geresh:
      "Geresh"
    case .gereshMuqdam:
      "Geresh Muqdam"
    case .gershayim:
      "Gershayim"
    case .qarneyPara:
      "Qarney Para"
    case .telishaGedola:
      "Teslisha Gedola"
    case .pazer:
      "Pazer"
    case .atnahHafukh:
      "Atnah Hafukh"
    case .munah:
      "Munah"
    case .mahapakh:
      "Mahapakh"
    case .merkha:
      "Merkha"
    case .merkhaKefula:
      "Merkha Kefula"
    case .darga:
      "Darga"
    case .qadma:
      "Qadma"
    case .telishaQetana:
      "Telisha Qetana"
    case .yerahBenYomo:
      "Yerah Ben Yomo"
    case .ole:
      "Ole"
    case .iluy:
      "Iluy"
    case .dehi:
      "Dehi"
    case .zinor:
      "Zinor"
    case .sheva:
      "Sheva"
    case .hatafSegol:
      "Hataf Segol"
    case .hatafPatah:
      "Hataf Patah"
    case .hatafQamats:
      "Hataf Qamats"
    case .hiriq:
      "Hiriq"
    case .tsere:
      "Tsere"
    case .segol:
      "Segol"
    case .patah:
      "Patah"
    case .qamats:
      "Qamats"
    case .holam:
      "Holam"
    case .holamHaserForVav:
      "Holam Haser For Vav"
    case .qubuts:
      "Qubuts"
    case .dagesh:
      "Dagesh"
    case .qamatsQatan:
      "Qamats Qatan"
    case .meteg:
      "Meteg"
    case .rafe:
      "Rafe"
    case .shinDot:
      "Shin Dot"
    case .sinDot:
      "Sin Dot"
    case .maqaf:
      "Maqaf"
    case .paseq:
      "Paseq"
    case .sofPasuq:
      "Sof Pasuq"
    case .nunHafukha:
      "Nun Hafukha"
    case .puncGeresh:
      "Punctuation Geresh"
    case .puncGershayim:
      "Punctuation Gershayim"
    case .masoraCircle:
      "Masora Circle"
    case .upperDot:
      "Upper Dot"
    case .lowerDot:
      "Lower Dot"
    }
  }
}
