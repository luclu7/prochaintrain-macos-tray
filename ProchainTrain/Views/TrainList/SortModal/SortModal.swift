//
//  SortModal.swift
//  ProchainTrain
//
//  Created by Lucie Delestre on 04/04/2022.
//

import SwiftUI

struct SortModal: View {
	var lines: [String]
	@Binding var sortEnabled: Bool
	@Binding var lineToShow: [String]
	@Environment(\.presentationMode) var presentationMode
	
	let columns = [
		GridItem(.flexible()),
		GridItem(.flexible()),
		GridItem(.flexible())
	]
	
    var body: some View {
		VStack {
			Toggle("Trier", isOn: $sortEnabled)
				.padding()
			LazyVGrid(columns: columns, spacing: 20) {
				ForEach(lines, id: \.self) { line in
					let _ = print(lines)
					SortModalRow(line: line, lineEnabled: $lineToShow)
				}
			}
			Button(action: {
				presentationMode.wrappedValue.dismiss()
			}, label: {
				Label("Valider", systemImage: "checkmark")
					.font(.system(size: 18))
					.frame(width: 200, height: 50)
			})
			.buttonStyle(.borderedProminent)
			//.buttonBorderShape(.capsule)
			.padding()
			
			
		

		}
		.padding()
	}
}

struct SortModal_Previews: PreviewProvider {
    static var previews: some View {
		SortModal(lines: ["RER_B", "RER_D","RER_E","TRAIN_H","TRAIN_K"], sortEnabled: .constant(true), lineToShow: .constant(["RER_B","RER_D","TRAIN_K"]))
			.previewDisplayName("Paris Nord")
			.previewLayout(.sizeThatFits)
    }
}
