import Foundation

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=6bc84d33bc7a4d2557ade60cca5070a2&units=metric"
    
    func fetchWeather( cityName: String ) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
//                    self.parseJSON(weatherData: safeData)
                    parseJSON(weatherData: safeData)
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString!)
                }
            }
            task.resume()
            
        }
        
    }
    
    func parseJSON(weatherData: Data) {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].id)
            print(getConditionName(weatherId: decodedData.weather[0].id))
        } catch {
            print(error)
        }
        
    }
    func getConditionName(weatherId: Int) -> String {
        
        switch weatherId {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
        }
        
    }
}
