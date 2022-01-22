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
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
        
    }
    
}
