//
//  TrainTransilien.swift
//  ProchainTrain
//
//  Created by Lucie Delestre on 06/02/2022.
//

import Foundation

// MARK: - Train
struct Train: Codable {
    let modeTransportEnum, lineTransportEnum, typeTrain, codeMission: String
    let idPA, trainNumber: String
    let affluenceEnabled, canceled: Bool
    let departureDate, departureTime, arrivalTime, destinationMission: String
    let platform: String
    let deservedStations: [deservedStations]
    let hasTraficDisruption, hasTravauxDisruption: Bool
    let disruptions: [Disruption]
}

extension Train: Identifiable {
    var id: String { return trainNumber+codeMission+departureTime }
}

// MARK: - deservedStation
struct deservedStations: Codable {
    let label: String
    let time: String?
}

extension deservedStations: Identifiable {
    var id: String { return label }
}
