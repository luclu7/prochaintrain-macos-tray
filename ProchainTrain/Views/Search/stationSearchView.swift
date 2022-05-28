//
//  stationSearchView.swift
//  ProchainTrain
//
//  Created by Lucie Delestre on 05/02/2022.
//


import SwiftUI
import CoreLocation
import MapKit

struct stationSearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = stationSearchViewModel()
    
    @EnvironmentObject var modelData: ModelData
    @Binding var selectedStation: String
        
	@State var filteredInput: Bool = false
	@State var filteringArray: [Destination] = []

    var body: some View {
            List {
				ForEach(filteredInput ? viewModel.filteredSearchResults(filteringArray: filteringArray) : viewModel.searchResults, id: \.self) { gare in
                    HStack{
                        Text(gare.label)
                        Spacer()
						
						if(self.selectedStation == gare.id) {
							Image(systemName: "checkmark")
								.foregroundColor(.blue)
						}
					}
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.selectedStation = gare.id
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Chercher une gare...")
            .navigationTitle("Gares")
    }
}

struct stationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        stationSearchView(selectedStation: .constant(ModelData().gares[3].id))
            .environmentObject(ModelData())
    }
}
