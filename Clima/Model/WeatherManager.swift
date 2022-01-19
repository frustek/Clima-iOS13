import Foundation

struct WeatherManager {
    
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=6bc84d33bc7a4d2557ade60cca5070a2&units=metric"
    
    func fetchWeather( cityName: String ) {
        let urlString = " \(weatherURL)&q=\(cityName)"
        print(urlString)
    }
    
}
