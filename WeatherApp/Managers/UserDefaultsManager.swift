//
//  UserDefaultsManager.swift
//  WeatherApp
//
//  Created by Ulixe on 27/11/24.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    // MARK: - Create
    func addElement<T: Codable>(_ element: T, to key: String) {
        var array: [T] = fetchArray(of: T.self, for: key)
        array.append(element)
        save(array, to: key)
    }
    
    // MARK: - Read
    func fetchArray<T: Decodable>(of type: T.Type, for key: String) -> [T] {
        guard let data = defaults.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([T].self, from: data)) ?? []
    }
    
    // MARK: - Update
    func updateElement<T: Codable>(at index: Int, with newValue: T, in key: String) {
        var array: [T] = fetchArray(of: T.self, for: key)
        guard array.indices.contains(index) else { return }
        array[index] = newValue
        save(array, to: key)
    }
    
    // MARK: - Delete
    func deleteElement<T: Codable>(of type: T.Type, at index: IndexSet, from key: String) {
        var array: [T] = fetchArray(of: type, for: key)
        guard array.indices.contains(index) else { return }
        array.remove(atOffsets: index)
        save(array, to: key)
    }
    
    // MARK: - Save Helper
    private func save<T: Codable>(_ array: [T], to key: String) {
        if let data = try? JSONEncoder().encode(array) {
            defaults.set(data, forKey: key)
        }
    }
    
    // MARK: - Delete Entire Array
    func deleteAll(from key: String) {
        defaults.removeObject(forKey: key)
    }
}
