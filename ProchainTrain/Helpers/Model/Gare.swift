//
//  Gare.swift
//  ProchainTrain
//
//  Created by Lucie Delestre on 05/02/2022.
//

import Foundation
#if !os(tvOS)
import CoreLocation
#endif

// MARK: - Gare
struct Gare: Codable, Hashable, Identifiable {
    let label, id: String
    let train, rer, tramway: Bool
    let keywords: [String] // à utiliser pour la recherche un jour
    let nbAutomates: Int
    let sncf, tempsReel, lignes: Bool
    
    var latitude: Double
    var longitude: Double
}

#if !os(tvOS) // no corelocation on tvOS
extension Gare {
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
    
    func distance(to location: CLLocation) -> CLLocationDistance {
        let from = CLLocation(latitude: latitude, longitude: longitude)
        
        return location.distance(from: from)
    }
    
}
#endif

typealias listeGares = [Gare]


struct apiDestinations: Codable, Hashable {
    let destinations: [Destination]
}



// MARK: - Destination
struct Destination: Codable, Hashable {
    let codeUic7, label: String
}

extension Destination: Identifiable {
    var id: String { return codeUic7 }
}

func findStationByName(_ gare: String) -> Gare? {
    return ModelData().gares.first(where: { $0.label == gare })
}

func findStationByID(_ id: String) -> Gare? {
    return ModelData().gares.first(where: { $0.id == id })
}
