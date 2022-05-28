// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let apiWelcome = try? newJSONDecoder().decode(apiWelcome.self, from: jsonData)

import Foundation

// MARK: - apiBase
struct apiBase: Codable {
    let platformAvailable, disruptionsAvailable, arrivalTimeAvailable: Bool
    let nextTrainsList: [Train]
	
	var lines: [String] {
		var lines: [String] = []
		for line in nextTrainsList {
			if(!lines.contains(line.lineTransportEnum)){
				lines.append(line.lineTransportEnum)
			}
		}
		lines.sort()
		
		return lines
	}
	
	var numberOfLines: Int {
		return lines.count
	}
    let departureStopArea: apiDepartureStopArea
}

// MARK: - apiDepartureStopArea
struct apiDepartureStopArea: Codable {
    let codeUic7, label, idPA: String
    let accessibilityServices: [Services]?
    let numberElevator: Int
    let automaton, hasElevator: Bool
}

extension apiDepartureStopArea: Identifiable {
    var id: String { return codeUic7 }
}

// MARK: - Services
struct Services: Codable {
    let name, nameWithParkingInfo: String
    let openingInfos: [String]?
}

extension Services: Identifiable {
    var id: String { return name+nameWithParkingInfo }
}
