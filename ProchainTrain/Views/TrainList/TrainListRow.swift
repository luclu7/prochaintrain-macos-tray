//
//  TrainRow.swift
//  ProchainTrain
//
//  Created by Lucie Delestre on 05/02/2022.
//

import SwiftUI

struct TrainListRow: View {
    var train: Train
    @Environment(\.colorScheme) var colorScheme // T4/T11
    
    var body: some View {
        HStack{
            if(train.codeMission == "TER") {
                Image("TER")
                    .resizable()
                    .frame(width: 25, height: 11.875)
            } else if(train.modeTransportEnum == "TRAM"){
                Image(colorScheme == .dark ? train.lineTransportEnum+"_dark" : train.lineTransportEnum+"_light")
                    .resizable()
                    .frame(width: 25, height: 25)
            } else {
            Image(train.lineTransportEnum)
                .resizable()
                .frame(width: 25, height: 25)
            }
			VStack(alignment: .leading) {
				Text(train.destinationMission)
					.strikethrough(train.canceled)
				
				if(train.codeMission != ""){
					Text("\(train.codeMission) \(train.typeTrain == "SHORT" ? "- Train court" : (train.typeTrain == "LONG" ? "- Train long" : ""))")
						.fontWeight(.light)
						.font(.system(size: 15))
						//.frame(width: 54, height: 20)
						//.background(RoundedRectangle(cornerRadius: 4).stroke(lineWidth: 1))
				}
			}
            
                        
            Spacer()
            
            ShowIfDisruptionOrCancelled(hasTraficDisruption: train.hasTraficDisruption, hasTravauxDisruption: train.hasTravauxDisruption, canceled: train.canceled)
            
            if(train.platform != ""){
                let PlatformCount = train.platform.count
                Text(train.platform)
                    .frame(width: 20*CGFloat(PlatformCount), height: 20)
                    .background(RoundedRectangle(cornerRadius: 4).stroke())
            }
            
            //Spacer()
            VStack {
                Text(train.departureTime)
					.strikethrough(train.canceled)
                
				Text(getDelayBetweenTrain(train))
                    .fontWeight(.light)
                    .font(.system(size: 13))
            }
                .frame(width: 54)


            

        }
    }
    
    func getDelayBetweenTrain(_ train: Train) -> String {
        let now = Date()
       
        let formatter = DateFormatter()
        formatter.dateFormat="yyyy-MM-dd HH:mm"
        guard let trainDate = formatter.date(from: train.departureDate+" "+train.departureTime) else {
            print("Oh no")
            return ""
        }
        
        let diff = Int(trainDate.timeIntervalSince1970 - now.timeIntervalSince1970)
print(diff)
        let minutes = diff / 60
        let string = "\(minutes) min"
        return string
    }

}

private struct ShowIfDisruptionOrCancelled: View {
    @State var hasTraficDisruption: Bool
    @State var hasTravauxDisruption: Bool
    @State var canceled: Bool
    
    var body: some View {
        if(hasTraficDisruption || hasTravauxDisruption || canceled){
            VStack{
                if(canceled){
                    Image(systemName: "exclamationmark.circle")
                        .foregroundColor(.red)
                        .scaledToFit()
                }
                
                if(hasTraficDisruption || hasTravauxDisruption) {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.orange)
                        .scaledToFit()
                }
            }
            .frame(width: 20)
            
        }
    }
}


struct TrainListRow_Previews: PreviewProvider {
    static var previews: some View {
        TrainListRow(train: Train(modeTransportEnum: "TRAIN", lineTransportEnum: "TRAIN_H", typeTrain: "LONG", codeMission: "VERA", idPA: "224", trainNumber: "124349", affluenceEnabled: true, canceled: false, departureDate: "2022-04-07", departureTime: "14:03", arrivalTime: "19:22", destinationMission: "Valmondois", platform: "1", deservedStations: [deservedStations(label: "Saint-Leu-la-Forêt", time: "19:03"), deservedStations(label: "Vaucelles", time: "19:06"), deservedStations(label: "Taverny", time: "19:08"), deservedStations(label: "Bessancourt", time: "19:10"), deservedStations(label: "Frépillon", time: "19:13"), deservedStations(label: "Méry-sur-Oise", time: "19:15"), deservedStations(label: "Mériel", time: "19:18"), deservedStations(label: "Valmondois", time: "19:22")],            hasTraficDisruption: false,            hasTravauxDisruption: false, disruptions: []))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Ligne H")
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")
            
        TrainListRow(train: Train(modeTransportEnum: "RER", lineTransportEnum: "RER_B", typeTrain: "UNKNOWN", codeMission: "PGUY", idPA: "527", trainNumber: "RATP-PGUY-220208", affluenceEnabled: true, canceled: false, departureDate: "2022-02-08", departureTime: "19:01", arrivalTime: "", destinationMission: "Saint-Rémy-lès-Chevreuse", platform: "", deservedStations: [deservedStations(label: "Châtelet les Halles", time: ""), deservedStations(label: "Saint-Michel Notre-Dame", time: ""), deservedStations(label: "Luxembourg", time: ""), deservedStations(label: "Port Royal", time: ""), deservedStations(label: "Denfert Rochereau", time: ""), deservedStations(label: "Cité Universitaire", time: ""), deservedStations(label: "Gentilly", time: ""), deservedStations(label: "Laplace", time: ""), deservedStations(label: "Arcueil - Cachan", time: ""), deservedStations(label: "Bagneux", time: ""), deservedStations(label: "Bourg-la-Reine", time: ""), deservedStations(label: "Parc de Sceaux", time: ""), deservedStations(label: "La Croix de Berny", time: ""), deservedStations(label: "Antony", time: ""), deservedStations(label: "Fontaine Michalon", time: ""), deservedStations(label: "Les Baconnets", time: ""), deservedStations(label: "Massy - Verrières", time: ""), deservedStations(label: "Massy - Palaiseau", time: ""), deservedStations(label: "Palaiseau", time: ""), deservedStations(label: "Palaiseau - Villebon", time: ""), deservedStations(label: "Lozère", time: ""), deservedStations(label: "Le Guichet", time: ""), deservedStations(label: "Orsay Ville", time: ""), deservedStations(label: "Bures-sur-Yvette", time: ""), deservedStations(label: "La Hacquinière", time: ""), deservedStations(label: "Gif-sur-Yvette", time: ""), deservedStations(label: "Courcelle sur Yvette", time: ""), deservedStations(label: "Saint-Rémy-lès-Chevreuse", time: "")], hasTraficDisruption: false, hasTravauxDisruption: true, disruptions: [] ))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("RER B")
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")
            
        TrainListRow(train: Train(modeTransportEnum: "DEFAULT", lineTransportEnum: "OTHER", typeTrain: "LONG", codeMission: "TER", idPA: "288", trainNumber: "847449", affluenceEnabled: false, canceled: false, departureDate: "2022-02-08", departureTime: "20:01", arrivalTime: "20:37", destinationMission: "Persan - Beaumont", platform: "19", deservedStations: [deservedStations(label: "Paris Gare du Nord", time: Optional("20:01")), deservedStations(label: "Persan - Beaumont", time: Optional("20:37"))], hasTraficDisruption: false, hasTravauxDisruption: false, disruptions: []))
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("TER")
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")
            
        TrainListRow(train: Train(modeTransportEnum: "TRAM", lineTransportEnum: "TRAM_T11", typeTrain: "SHORT", codeMission: "", idPA: "256", trainNumber: "113239.27.TLN.8.F.213500", affluenceEnabled: false, canceled: true, departureDate: "2022-02-08", departureTime: "21:35", arrivalTime: "21:50", destinationMission: "Le Bourget", platform: "1", deservedStations: [deservedStations(label: "Épinay-sur-Seine", time: Optional("21:35")), deservedStations(label: "Épinay - Villetaneuse", time: Optional("21:38")), deservedStations(label: "Villetaneuse Université", time: Optional("21:40")), deservedStations(label: "Pierrefitte - Stains", time: Optional("21:42")), deservedStations(label: "Stains la Cerisaie", time: Optional("21:45")), deservedStations(label: "Dugny - La Courneuve", time: Optional("21:47")), deservedStations(label: "Le Bourget", time: Optional("21:50"))], hasTraficDisruption: true, hasTravauxDisruption: true, disruptions: []))
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("T11 jour")
            .preferredColorScheme(.light)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")
            
        TrainListRow(train: Train(modeTransportEnum: "TRAM", lineTransportEnum: "TRAM_T11", typeTrain: "SHORT", codeMission: "", idPA: "256", trainNumber: "113239.27.TLN.8.F.213500", affluenceEnabled: false, canceled: false, departureDate: "2022-02-08", departureTime: "21:35", arrivalTime: "21:50", destinationMission: "Le Bourget", platform: "1", deservedStations: [deservedStations(label: "Épinay-sur-Seine", time: Optional("21:35")), deservedStations(label: "Épinay - Villetaneuse", time: Optional("21:38")), deservedStations(label: "Villetaneuse Université", time: Optional("21:40")), deservedStations(label: "Pierrefitte - Stains", time: Optional("21:42")), deservedStations(label: "Stains la Cerisaie", time: Optional("21:45")), deservedStations(label: "Dugny - La Courneuve", time: Optional("21:47")), deservedStations(label: "Le Bourget", time: Optional("21:50"))], hasTraficDisruption: true, hasTravauxDisruption: false, disruptions: []))
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("T11 nuit")
            .preferredColorScheme(.dark)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")
        
        TrainListRow(train: Train(modeTransportEnum: "TRAM", lineTransportEnum: "TRAM_T4", typeTrain: "SHORT", codeMission: "", idPA: "99", trainNumber: "111818", affluenceEnabled: false, canceled: false, departureDate: "2022-03-11", departureTime: "14:51", arrivalTime: "15:23", destinationMission: "Bondy", platform: "2CM", deservedStations: [deservedStations(label: "Hôpital de Montfermeil", time: Optional("14:51")), deservedStations(label: "Arboretum", time: Optional("14:55")), deservedStations(label: "Notre-Dame-des-Anges", time: Optional("14:58")), deservedStations(label: "Clichy - Montfermeil", time: Optional("15:00")), deservedStations(label: "Romain Rolland", time: Optional("15:02")), deservedStations(label: "Clichy-sous-Bois - Mairie", time: Optional("15:04")), deservedStations(label: "Maurice Audin", time: Optional("15:06")), deservedStations(label: "Léon Blum", time: Optional("15:08")), deservedStations(label: "République - Marx Dormoy", time: Optional("15:11")), deservedStations(label: "Gargan", time: Optional("15:14")), deservedStations(label: "Les Pavillons-sous-Bois", time: Optional("15:16")), deservedStations(label: "Allée de la Tour-Rendez-vous", time: Optional("15:18")), deservedStations(label: "Les Coquetiers", time: Optional("15:20")), deservedStations(label: "Remise à Jorelle", time: Optional("15:23")), deservedStations(label: "Bondy", time: Optional("15:23"))], hasTraficDisruption: false, hasTravauxDisruption: false, disruptions: []))
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("T11 nuit")
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")

    }
}
