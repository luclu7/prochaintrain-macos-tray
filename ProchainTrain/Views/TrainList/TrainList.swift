//
//  TrainList.swift
//  ProchainTrain
//
//  Created by Lucie Delestre on 05/02/2022.
//

import SwiftUI

struct TrainList: View {
	@StateObject private var viewModel = TrainListViewModel()
	@Environment(\.colorScheme) var colorScheme // à l'aide

    var station: Gare
	var destination: Gare
	var hideTitle: Bool = false
	
	@State var showSortModal: Bool = false
	@State var sortEnabled: Bool = false
	@State var lineToShow: [String] = []
    
    var body: some View {
            VStack{
				ZStack{
				}
				.onAppear() {
					viewModel.getTrains(station, arrivee: destination)
					self.lineToShow = viewModel.apiData.lines
				}
				.multilineTextAlignment(.center)

				HStack {
					Text("Prochain trains de \(station.label) à \(destination.label)")
						.navigationTitle("Liste des trains")
					Spacer()
					Button {
						viewModel.trains = []
						viewModel.getTrains(station, arrivee: destination)
					} label: {
						Image(systemName: "arrow.clockwise")
					}
				}
				.padding(.horizontal, 5)

                
                
                if(viewModel.trains.count != 0) {
                    if(viewModel.trains.first?.modeTransportEnum != "INEXISTANT") {
                            VStack {
								ForEach(viewModel.trains) { train in
									if(!sortEnabled || lineToShow.contains(train.lineTransportEnum)){
										TrainListRow(train: train)
											.padding(.horizontal, 10)
//										.listRowBackground(train.canceled ? Color.red.opacity(0.2) : (colorScheme == .dark ? Color.black : Color.white))
									}
                                }
                            }
                            .refreshable {
                                viewModel.getTrains(station, arrivee: destination)
                            }
                        } else {
                            Text("Aucun train ici!")
                            Spacer()
                        }
                    } else {
                        VStack {
                            Text("Chargement...")
                                .frame(alignment: .center)
                            ProgressView()
                        }
                        .frame(width: 200, alignment: .center)
                        Spacer()

                }
            }
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.text), dismissButton: alertItem.dissmissButton)
            }
		#if !os(watchOS)
			.toolbar {
				ToolbarItem() {
					if(viewModel.apiData.numberOfLines>1){
						Toggle(isOn: $showSortModal) {
							Image(systemName: "arrow.up.arrow.down")
						}
					}
				}
			}
		#endif
			.sheet(isPresented: $showSortModal) {
				SortModal(lines: viewModel.apiData.lines, sortEnabled: $sortEnabled, lineToShow: $lineToShow)
			}
    }
}

struct TrainList_Previews: PreviewProvider {
    static var previews: some View {
		TrainList(station: findStationByName("Paris Gare du Nord")!, destination: findStationByName("Saint-Denis")!)
            .previewDisplayName("Saint-Leu-La-Forêt")
		//TrainList(station: findStationByName("Paris Saint-Lazare")!)
			//.previewDisplayName("Saint-Leu-La-Forêt")
    }
}
