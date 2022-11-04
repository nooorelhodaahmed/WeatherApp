//
//  ViewModel.swift
//  WeatherApp
//
//  Created by norelhoda on 02/11/2022.
//

import Foundation
import Alamofire

struct DailyWeatherData{
  
    var time : String
    var cityName: String
    var wetahericon : String
    var tempratureDegree: Double
    var tempratureDescription: String
    var wind : Double
    var humidity : Int
}

class ViewModel {
    
    //MARK: - Proporties
    
    var dayArray = ["Today","Tomorrow","Friday"]
    var data : DailyWeatherModel?
    var weatherByDayData : ThreeDaysModel?
    var cities = [String]()
    var dailyWeatherDataUpdat : (()->())?
    var ThreeDaysWeatherDataUpdat : (()->())?
    var fetchCitiesData : (()->())?
    
    //MARK: - Helper Function
        
    func getDailyWeather(cityName:String){
        AppServices().getDailyweatherData(cityName: cityName) { (success) in
            if  success != nil {
                self.data = success
                self.dailyWeatherDataUpdat?()
            }
        }
    }
    
    func fetchThreeDaysWeather(cityName:String){
        AppServices().getWeatherByDay(cityName: cityName) { success in
            if  success != nil {
                self.weatherByDayData = success
                self.ThreeDaysWeatherDataUpdat?()
            }
        }
    }
    
    func fetchCities(){
        AppServices().fetchCities { success in
            for i in 0..<success.count {
                if let name = success[i].name {
                    self.cities.append(name)
                }
            }
            self.fetchCitiesData?()
        }
    }
    
}

