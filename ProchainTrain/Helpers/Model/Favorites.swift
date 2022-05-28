//
//  File.swift
//  ProchainTrain
//
//  Created by Lucie Delestre on 08/02/2022.
//
// stolen from https://stackoverflow.com/questions/66111073/saving-favorites-to-userdefaults-using-struct-id

import Foundation
import SwiftUI

class Favorites: ObservableObject {
    private var gares: Set<Gare> = []
    private var favorites: Set<String> = []
    let defaults = UserDefaults.standard

    var initialItems: [Gare] = []

    init() {
        let decoder = PropertyListDecoder()
        
        if let data = defaults.data(forKey: "Gares") {
            gares = (try? decoder.decode(Set<Gare>.self, from: data)) ?? Set(initialItems)
        } else {
            gares = Set(initialItems)
        }
        self.favorites = Set(defaults.array(forKey: "Favorites") as? [String] ?? [])
    }

    func getTaskIds() -> Set<String> {
        return self.favorites
    }
    
    func get() -> [Gare] {
        var gares: [Gare] =  []

        for favoriteId in favorites {
            if let gare = ModelData().gares.first(where: {$0.id == favoriteId}) {
                gares.append(gare)
            } else {
               print("oops") // panic
            }
        }
        
        // trie le nombre de gares dans l'ordre alphabétique sans prendre en compte les accents/majuscules
        gares = gares.sorted(by: {$0.label.folding(options: .diacriticInsensitive, locale: Locale.current) < $1.label.folding(options: .diacriticInsensitive, locale: Locale.current)})
        
        return gares
    }

    func contains(_ gare: Gare) -> Bool {
        favorites.contains(gare.id)
    }

    func add(_ gare: Gare) {
        favorites.insert(gare.id)
        save()
    }

    func remove(_ gare: Gare) {
        favorites.remove(gare.id)
        save()
    }

    func save() {
        let encoder = PropertyListEncoder()
        if let encoded = try? encoder.encode(self.gares) {
            self.defaults.set(encoded, forKey: "Gares")
        }
        self.defaults.set(Array(self.favorites), forKey: "Favorites")
        defaults.synchronize()
    }
}
