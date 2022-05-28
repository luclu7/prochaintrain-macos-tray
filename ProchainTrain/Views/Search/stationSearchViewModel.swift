//
//  stationSearchViewModel.swift
//  ProchainTrain
//
//  Created by Lucie Delestre on 09/03/2022.
//

import SwiftUI
import Foundation
import CoreLocation

final class stationSearchViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var searchText = ""
	@State var filteredInput: Bool = false
	@State var filteringArray: [Destination] = []
	
	@Published var alertItem: AlertConfig?
	
	func filteredSearchResults(filteringArray: [Destination]) -> [Gare] {
		let resultsCopy = self.searchResults
		var arrayOfStations = [Gare]()
		
		for result in resultsCopy {
			if(filteringArray.first(where: { $0.id == result.id }) != nil) {
				print("Gare trouvée !")
				print(result.label)
				arrayOfStations.append(result)
			}
		}
		
		return arrayOfStations
	}
    
    var searchResults: [Gare] {
		if searchText.isEmpty {
            return ModelData().gares
        } else {
            return ModelData().gares.filter {
                $0.keywords.joined(separator: "").range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil
                ||
                $0.label.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil

            }
        }
    }
}
