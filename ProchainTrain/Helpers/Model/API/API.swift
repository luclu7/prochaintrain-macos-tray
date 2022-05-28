//
//  API.swift
//  ProchainTrain
//
//  Created by Lucie Delestre on 05/02/2022.
//

import Foundation
import SwiftUI

class Api : ObservableObject{
    @Published var Trains = [Train]()
    @Published var Elevators = [Elevator]()
    
    enum ErrorType: Error {
        case invalidURL
        case unableToComplete
        case invalidResponse
        case invalidData
    }
    
    func loadTrains(station: Gare, arrivee: Gare?, completion:@escaping (Result<apiBase, ErrorType>) -> ()) {
        var urlToUse: String
        var apiServer: String
        apiServer = UserDefaults.standard.string(forKey: "apiServer") ?? "prod"
        
        switch apiServer {
        case "prod":
            urlToUse = "https://compo.luc.ovh/transilienrt/trainscom?depart="

        case "debug1":
            urlToUse = "https://compo.luc.ovh/transilienrt/trains1?depart="

        case "debug2":
            urlToUse = "https://compo.luc.ovh/transilienrt/trains2?depart="

        case "debug3":
            urlToUse = "https://compo.luc.ovh/transilienrt/trains3?depart="
            
        case "debug4":
            urlToUse = "https://compo.luc.ovh/transilienrt/trains4?depart="

        case "debug5":
            urlToUse = "https://compo.luc.ovh/transilienrt/trains5?depart="
            
        case "debug6":
            urlToUse = "https://compo.luc.ovh/transilienrt/trains6?depart="
            
        case "debug7":
            urlToUse = "https://compo.luc.ovh/transilienrt/trains7?depart="

        case "debug8":
            urlToUse = "https://compo.luc.ovh/transilienrt/trains8?depart="
            
        default:
            urlToUse = "https://compo.luc.ovh/transilienrt/trainscom?depart="
        }
        
		if(arrivee != nil) {
			urlToUse = urlToUse+"\(station.id)&arrivee=\(arrivee?.id ?? "")"
		}
		else {
			urlToUse = urlToUse+"\(station.id)"
		}
		print(urlToUse)
		
        guard let url = URL(string: urlToUse) else {
            print("Invalid url...")
            completion(.failure(.invalidURL))
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
                let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
                print(urlContent)
            }
            
            if let _ =  error {
                completion(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            var apiReturn: apiBase
            
            do {
                let decoder = JSONDecoder()
                apiReturn = try decoder.decode(apiBase.self, from: data)
                //completed(.success(decodedResponse.request))
            } catch {
                completion(.failure(.invalidData))
                return
            }
            
            //let trains = [Train(date: "05/02/2022 15:23", num: 124699, miss: "POVA", term: 87276469)]
            print(apiReturn.nextTrainsList)
            print(apiReturn.departureStopArea)
            print(apiReturn.nextTrainsList.count)
            let toReturn: apiBase
            if(apiReturn.nextTrainsList.count != 0) {
                toReturn = apiReturn
            } else {
                toReturn = apiBase(platformAvailable: true, disruptionsAvailable: true, arrivalTimeAvailable: false, nextTrainsList: [Train(modeTransportEnum: "INEXISTANT", lineTransportEnum: "NONE", typeTrain: "RIEN", codeMission: "NADA", idPA: "0", trainNumber: "0", affluenceEnabled: false, canceled: false, departureDate: "0", departureTime: "0", arrivalTime: "0", destinationMission: "", platform: "0", deservedStations: [], hasTraficDisruption: false, hasTravauxDisruption: false, disruptions: [])], departureStopArea: apiDepartureStopArea(codeUic7: "1", label: "tkt", idPA: "0", accessibilityServices: [], numberElevator: 2, automaton: true, hasElevator: true))
            }
                
            DispatchQueue.main.async {
                completion(.success(toReturn))
            }
        }.resume()
        
    }
    
    func getElevatorStatus(station: Gare, completion:@escaping (Result<apiElevator, ErrorType>) -> ()) {
        var urlToUse: String
        
        urlToUse = "https://www.transilien.com/api/station/elevators?uicStation="
        
        guard let url = URL(string: urlToUse+String(station.id)) else {
            print("Invalid url...")
            completion(.failure(.invalidURL))
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
                let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
                print(urlContent)
            }
            
            if let _ =  error {
                completion(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            var apiReturn: apiElevator
            
            do {
                let decoder = JSONDecoder()
                apiReturn = try decoder.decode(apiElevator.self, from: data)
                //completed(.success(decodedResponse.request))
            } catch {
                completion(.failure(.invalidData))
                return
            }
            
            //let trains = [Train(date: "05/02/2022 15:23", num: 124699, miss: "POVA", term: 87276469)]
            print(apiReturn.elevators)
            
            DispatchQueue.main.async {
                completion(.success(apiReturn))
            }
        }.resume()
    }
    
    func getInfoTrafic(completion:@escaping (Result<infoTraficBase, ErrorType>) -> ()) {
        var urlToUse: String
        
        urlToUse = "https://compo.luc.ovh/transilienrt/infoTrafic"
        
        guard let url = URL(string: urlToUse) else {
            print("Invalid url...")
            completion(.failure(.invalidURL))
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
                let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
                print(urlContent)
            }
            
            if let _ =  error {
                completion(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            var apiReturn: infoTraficBase
            
            do {
                let decoder = JSONDecoder()
                apiReturn = try decoder.decode(infoTraficBase.self, from: data)
                //completed(.success(decodedResponse.request))
            } catch {
                completion(.failure(.invalidData))
                return
            }
            
            //let trains = [Train(date: "05/02/2022 15:23", num: 124699, miss: "POVA", term: 87276469)]
            print(apiReturn.rer.count)
            
            DispatchQueue.main.async {
                completion(.success(apiReturn))
            }
        }.resume()
    }
	
	func getDestinations(station: Gare, completion:@escaping (Result<[Destination], ErrorType>) -> ()) {
		var urlToUse: String
		
		urlToUse = "https://compo.luc.ovh/transilienrt/destinations?from="+station.id
		
		guard let url = URL(string: urlToUse) else {
			print("Invalid url...")
			completion(.failure(.invalidURL))
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			if let data = data,
			   let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
				print(urlContent)
			}
			
			if let _ =  error {
				completion(.failure(.unableToComplete))
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completion(.failure(.invalidResponse))
				return
			}
			
			guard let data = data else {
				completion(.failure(.invalidData))
				return
			}
			
			var apiReturn: [Destination]
			
			do {
				let decoder = JSONDecoder()
				apiReturn = try decoder.decode([Destination].self, from: data)
				//completed(.success(decodedResponse.request))
			} catch {
				completion(.failure(.invalidData))
				return
			}
			
			//let trains = [Train(date: "05/02/2022 15:23", num: 124699, miss: "POVA", term: 87276469)]
			print(apiReturn.count)
			
			DispatchQueue.main.async {
				completion(.success(apiReturn))
			}
		}.resume()
	}
    
//    func getDestinations(station: Gare, completion:@escaping ([Gare]) -> ()) {
//        var urlToUse: String
//
//        urlToUse =
//
//        guard let url = URL(string: urlToUse+String(station.id)) else {
//            print("Invalid url...")
//            return
//        }
//
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data,
//                let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                print(urlContent)
//            }
//
//            let apiData = try! JSONDecoder().decode(apiDestinations.self, from: data!)
//
//            //let trains = [Train(date: "05/02/2022 15:23", num: 124699, miss: "POVA", term: 87276469)]
//            print(apiData)
//            print(apiData.destinations)
//            var toReturn: [Gare] = []
//
//            for dest in apiData.destinations {
//                let item: Gare = ModelData().gares.first(where: { $0.id == dest.codeUic7 }) ?? Gare(label: "Oups", id: "1", train: false, rer: false, tramway: false, keywords: [], nbAutomates: 0, sncf: false, tempsReel: false, lignes: false, latitude: 0, longitude: 0)
//                toReturn.append(item)
//            }
//
//            DispatchQueue.main.async {
//                completion(toReturn)
//            }
//        }.resume()
//
//    }

}
