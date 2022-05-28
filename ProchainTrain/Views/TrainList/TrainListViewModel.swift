//
//  TrainListViewModel.swift
//  ProchainTrain
//
//  Created by Lucie Delestre on 01/03/2022.
//

import Foundation

class TrainListViewModel: ObservableObject {
    @Published var trains = [Train]()
    @Published var apiData: apiBase = apiBase(platformAvailable: false, disruptionsAvailable: false, arrivalTimeAvailable: false, nextTrainsList: [], departureStopArea: apiDepartureStopArea(codeUic7: "", label: "", idPA: "", accessibilityServices: [], numberElevator: 999, automaton: true, hasElevator: true))
    @Published var alertItem: AlertConfig?


	func getTrains(_ gare: Gare, arrivee: Gare?) {
        Api().loadTrains(station: gare, arrivee: arrivee) { [self] result in
            DispatchQueue.main.async {

                switch result {
                case .success(let apiData):
                    self.apiData = apiData
                    self.trains = apiData.nextTrainsList

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
                }
            }
        }
    }
}
