//
//  InfoTafic.swift
//  ProchainTrain
//
//  Created by Lucie Delestre on 05/03/2022.
//

import Foundation

// MARK: - infoTraficBase
struct infoTraficBase: Codable, Hashable {
    let rer, metro, train, tram: [infoTraficLine]
}

// MARK: - infoTraficMetro
struct infoTraficLine: Codable, Hashable {
    let transportMode, transportLine, lineCode: String
    let currentDisruptions, futureDisruptions: [infoTraficDisruption]
    let currentTrafficDisruptionsCount, currentWorksDisruptionsCount: Int
    let hasTrafficDisruptions, hasWorksDisruptions: Bool
}

extension infoTraficLine: Identifiable {
    var id: String { return transportLine }
}

// MARK: - infoTraficDisruption
struct infoTraficDisruption: Codable, Hashable, Identifiable {
    let id, modifiedDate, category, title: String
    let detail: String
    let hasSubstitutionBus: Bool
}

enum typeTransport: String, CaseIterable, Identifiable {
    case rer, train, metro, tram
    var id: Self { self }
}
