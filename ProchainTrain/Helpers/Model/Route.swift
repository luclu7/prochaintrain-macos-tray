//
//  Route.swift
//  ProchainTrainMenuBar
//
//  Created by Lucie Delestre on 26/05/2022.
//  Copyright © 2022 Golden Chopper. All rights reserved.
//

import Foundation

struct Route {
	var departure: Gare
	var destination: Gare
}

enum whichRoute: String, CaseIterable, Identifiable {
	case aller, retour
	var id: Self { self }
}
