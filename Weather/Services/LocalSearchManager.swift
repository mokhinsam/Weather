//
//  LocalSearchManager.swift
//  Weather
//
//  Created by Дарина Самохина on 25.03.2025.
//

import MapKit

class LocalSearchManager: NSObject {
    
    static let shared = LocalSearchManager()
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults: [MKLocalSearchCompletion] = []
    private var onSearch: (([MKLocalSearchCompletion]) -> Void)?
    
    override private init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
    }
    
    func search(text: String, completion: @escaping (([MKLocalSearchCompletion]) -> Void)) {
        if !text.isEmpty {
            searchCompleter.queryFragment = text
            onSearch = completion
        }
    }
}

//MARK: - MKLocalSearchCompleterDelegate
extension LocalSearchManager: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let results = completer.results.filter { result in
            guard result.title.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil else { return false }
            guard result.subtitle.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil else { return false }
            return true
        }
        searchResults = results
        onSearch?(searchResults)
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: any Error) {
        print("Error didFailWithError in LocalSearchManager: \(error), \(error.localizedDescription)")
    }

}
