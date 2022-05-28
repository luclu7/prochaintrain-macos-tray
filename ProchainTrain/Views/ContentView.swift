//
//  ContentView.swift
//  ProchainTrainMenuBar
//
//  Created by luclu7 on 26/05/2022.
//  Copyright © 2022 luclu7. All rights reserved.
//

import SwiftUI
import AppKit

struct ContentView: View {
	@StateObject private var viewModel = ContentViewModel()

	@AppStorage("departure") var departure: String = "8727660"
	@AppStorage("arrival") var arrival: String = "8727112"
	@State private var selectedRoute: whichRoute = .aller
	@State private var showSettings: Bool = false
	
    var body: some View {
		VStack(alignment: .leading, spacing: 0) {
		
			HStack {
				Text(showSettings ? "Paramètres" : "Prochain départs" )
					.font(Font.system(size: 24))
					.fontWeight(.light)
					.multilineTextAlignment(.leading)
					.padding(.horizontal, 16.0)
					.padding(.vertical, 2.0)
				Spacer()
				Button {
					withAnimation(.spring()) {
						self.showSettings.toggle()
					}
				} label: {
					Image(systemName: "gear")
				}
				.padding(.horizontal, 5.0)
			}
		if(showSettings) {
			Form {
				Section(header: Text("Depart")) {
					stationSearchView(selectedStation: $departure)
					.frame(height: 150)
				}
				.onChange(of: departure) { newValue in
					print(departure)
					viewModel.getDestinations(findStationByID(newValue)!)
					
					withAnimation {
						self.arrival = ""
					}
				}

				Section(header: Text("Arrivée")) {
					stationSearchView(selectedStation: $arrival, filteringArray: viewModel.destinations)
					.frame(height: 150)
				}
			}
		} else {
		
                //.frame(width: 360.0, height: 320.0, alignment: .topLeading)
			Picker("", selection: $selectedRoute) {
				Text("Aller").tag(whichRoute.aller)
				Text("Retour").tag(whichRoute.retour)
			}
			.pickerStyle(.segmented)
			if(departure != "" && arrival != "") {
				if(selectedRoute  == .aller) {
				TrainList(station: findStationByID(departure)!, destination: findStationByID(arrival)!)
				} else {
					TrainList(station: findStationByID(arrival)!, destination: findStationByID(departure)!)
				}
			}
			Spacer()
			Button(action: {
                NSApplication.shared.terminate(self)
            })
            {
                Text("Fermer")
                .font(.caption)
                .fontWeight(.semibold)
            }
            .padding(.trailing, 16.0)
			.padding(.vertical, 5.0)
            .frame(width: 360.0, alignment: .trailing)
        }
    }
		.padding(0)
		.frame(width: 360.0, height: 360.0, alignment: .top)
	}
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
