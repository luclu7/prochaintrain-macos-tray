//
//  SortModalRow.swift
//  ProchainTrain
//
//  Created by Lucie Delestre on 04/04/2022.
//

import SwiftUI

struct SortModalRow: View {
	@Environment(\.colorScheme) var colorScheme // T4/T11

	var line: String
	@Binding var lineEnabled: [String]
	
    var body: some View {
		Button{
			//UIImpactFeedbackGenerator(style: .soft).impactOccurred()
			
			if(lineEnabled.contains(line)){ // remove element from array
				lineEnabled = lineEnabled.filter { $0 != line }
			} else { // add element to array
				lineEnabled.append(line)
			}
			//UIImpactFeedbackGenerator(style: .soft).impactOccurred()
		} label: {
			ZStack {
				//Color.secondary
				HStack(alignment: .center) {
					if(line == "OTHER") {
						Image("TER")
							.resizable()
							.frame(width: 25, height: 11.875)
					} else if(line.hasPrefix("TRAM")){
						Image(colorScheme == .dark ? line+"_dark" : line+"_light")
							.resizable()
							.frame(width: 25, height: 25)
					} else {
						Image(line)
							.resizable()
							.frame(width: 25, height: 25)
					}
					Image(systemName: lineEnabled.contains(line) ? "eye" : "eye.slash")
						.foregroundColor(lineEnabled.contains(line) ? Color.blue : Color.red)
				}
			}.padding()
				.overlay(
					RoundedRectangle(cornerRadius: 16)
						.stroke(Color.blue, lineWidth: 4)
				)
		}
    }
}

struct SortModalRow_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			HStack {
				SortModalRow(line: "RER_A", lineEnabled: .constant(["RER_A"]))
				SortModalRow(line: "RER_B", lineEnabled: .constant([""]))
				SortModalRow(line: "OTHER", lineEnabled: .constant(["RER_E"]))
			}
			HStack {
				SortModalRow(line: "TRAIN_H", lineEnabled: .constant(["[RER_A]"]))
				SortModalRow(line: "TRAIN_N", lineEnabled: .constant(["[TRAIN_N]"]))
				SortModalRow(line: "TRAM_T11", lineEnabled: .constant(["[TRAM_T11]"]))
			}
		}
		.previewLayout(.fixed(width: 310, height: 140))
	}
}
