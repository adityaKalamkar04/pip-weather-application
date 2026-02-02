//
//  TodayViewModel.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 23/01/26.
//

import Foundation
import Combine

final class TodayViewModel: ObservableObject {
    @Published var todayItems: [TodayItem] = []
    @Published var weatherForecast: WeatherForecast?
    @Published var user: User?
    @Published var dateDisplay: String = "May 8"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func loadToday() {
        isLoading = true
        errorMessage = nil
        
        let result = JSONLoader.load(TodayResponse.self, from: "today")
        
        switch result {
        case .success(let response):
            self.todayItems = response.data.todayItems
            self.weatherForecast = response.data.weatherForecast
            self.user = response.data.user
            self.dateDisplay = response.data.date.fullDate
            self.isLoading = false
            DeviceDetector.log("Loaded today items: \(todayItems.count)", type: .success)
            
        case .failure(let error):
            self.errorMessage = error.localizedDescription
            self.isLoading = false
            DeviceDetector.log("Failed to load today: \(error)", type: .error)
        }
    }
}
