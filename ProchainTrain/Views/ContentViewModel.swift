//
//  TrainListHomeViewModel.swift
//  ProchainTrain
//
//  Created by Lucie Delestre on 16/05/2022.
//

import Foundation
import SwiftUI

final class ContentViewModel: NSObject, ObservableObject {
	//@AppStorage("isLocationEnabled") private var isLocationEnabled = false
	@Published var destinations: [Destination] = []
	@Published var alertItem: AlertConfig?

	func getDestinations(_ gare: Gare) {
		Api().getDestinations(station: gare) { [self] result in
			DispatchQueue.main.async {
				
				switch result {
				case .success(let destinations):
					self.destinations = destinations
					
				case .failure(let error):
					switch error {
					case .invalidData:
						self.alertItem = alertValue.invalidData

					case .invalidURL:
						self.alertItem = alertValue.invalidURL

					case .invalidResponse:
						self.alertItem = alertValue.invalidResponse

					case .unableToComplete:
						self.alertItem = alertValue.unableToComplete
					}
					print("ah merde")
					print(error)
				}
			}
		}
	}
	
}
