//
//  NetworkAlerts.swift
//  ProchainTrain
//
//  Created by Lucie Delestre on 01/03/2022.
//

import Foundation
import SwiftUI

struct AlertConfig: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var dissmissButton: Alert.Button?
}

enum alertValue {
    static let invalidURL = AlertConfig(title: "Mauvaise URL", text: "Essayez de changer de serveur dans les paramètres", dissmissButton: .default(Text("OK")))
    static let unableToComplete = AlertConfig(title: "Erreur réseau", text: "Êtes-vous connecté à Internet?", dissmissButton: .default(Text("OK")))
    static let invalidResponse = AlertConfig(title: "Erreur serveur", text: "Réessayez plus tard.", dissmissButton: .default(Text("OK")))
    static let invalidData = AlertConfig(title: "Erreur serveur", text: "", dissmissButton: .default(Text("OK")))
}
