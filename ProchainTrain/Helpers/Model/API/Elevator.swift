//
//  Elevator.swift
//  ProchainTrain
//
//  Created by Lucie Delestre on 09/02/2022.
//

import Foundation

// MARK: - apiWelcome
struct apiElevator: Codable, Hashable {
    let total, operationalCount: Int
    let elevators: [Elevator]
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - apiElevator
struct Elevator: Codable, Hashable {
    let state, location: String
}

extension Elevator: Identifiable {
    var id: String { return UUID().uuidString }
}
