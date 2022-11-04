//
//  AppServices.swift
//  WeatherApp
//
//  Created by norelhoda on 04/11/2022.
//

import Alamofire
import AlamofireMapper

class AppServices{
    
    //MARK: PostAppLog
    
    public func getDailyweatherData(cityName:String, successCompletion: @escaping ((_ json : DailyWeatherModel) -> Void))
    {
        let headers = ["Content-Type" : "application/json"]
        Alamofire.request(EndPiont.weatherUrl+"/current.json?key=\(EndPiont.apiKey)&q=London" , method: .get, encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<DailyWeatherModel>) in
            switch response.result {
            case .success(let json):
               print(json)
                successCompletion(json)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    public func getWeatherByDay(cityName:String, successCompletion: @escaping ((_ json : ThreeDaysModel) -> Void))
    {
        let headers = ["Content-Type" : "application/json"]
         Alamofire.request(EndPiont.weatherByDayUrl+"\(EndPiont.apiKey)&q=London&days=3" , method: .get, encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<ThreeDaysModel>) in
            switch response.result {
                
               case .success(let json):
                print(json)
                successCompletion(json)
                break
                case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    public func fetchCities(successCompletion: @escaping ((_ json : [CitiesModel]) -> Void))
    {
        let headers = ["Content-Type" : "application/json"]
        print(EndPiont.citiesUrl+"\(EndPiont.apiKey)&q=London")
        
         Alamofire.request(EndPiont.citiesUrl+"\(EndPiont.apiKey)&q=London" , method: .get, encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<[CitiesModel]>) in
            switch response.result {
                
               case .success(let json):
                print(json)
                successCompletion(json)
                break
                case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
}
