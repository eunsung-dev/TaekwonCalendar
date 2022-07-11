public struct CreditCardScannerError: LocalizedError {
  public enum Kind { case cameraSetup, photoProcessing, authorizationDenied, capture }
  public var kind: Kind
  public var underlyingError: Error?
  public var errorDescription: String? { (underlyingError as? LocalizedError)?.errorDescription }
}

public struct CreditCard {
  public var number: String?
  public var name: String?
  public var expireDate: DateComponents?
  public var year: Int { expireDate?.year ?? 0 } // This returns "yyyy"
  public var month: Int { expireDate?.month ?? 0 } // This returns "MM"
  /*
  CardVender below returns an element of an enum:
  Unknown, Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay
  */
  public var vendor: CardVendor { CreditCardUtil.getVendor(candidate: self.number) }
  public var isNotExpired: Bool? { CreditCardUtil.isValid(candidate: self.expireDate) }
}

public enum CardVendor: String {
    case Unknown, Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay
}
