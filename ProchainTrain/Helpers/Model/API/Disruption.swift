//
//  Perturbation.swift
//  ProchainTrain
//
//  Created by Lucie Delestre on 11/02/2022.
//

import Foundation

// MARK: - apiDisruption
struct Disruption: Codable, Hashable {
    let creationDate: String?
    let updateDate, title, type: String
    let validityPeriods: [apiValidityPeriod]
    let detail, startingApplicationDate: String
    let hasSubstitutionBus: Bool
    let line: String
    let transport: apiTransport
}

extension Disruption: Identifiable {
    var id: String { return title+type+updateDate }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - apiTransport
struct apiTransport: Codable, Hashable {
    let mode: String
    let line: apiLine
    let substitution: Bool
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - apiLine
struct apiLine: Codable, Hashable {
    let label: String
    let desc: String?
    let code: String
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - apiValidityPeriod
struct apiValidityPeriod: Codable, Hashable {
    let startDate, endDate: String
    let now: Bool
}

