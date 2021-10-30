import Foundation
import Moya

let apiKey = "df29311bdc0fb205768405bd65a49562"
let defaultCountry = "London, UK"
let url = "https://api.openweathermap.org/data/2.5"
enum APIService {
    case getWeather(lat: Double, long: Double)
    case getWeatherByCountaryName
    case getListWeatherForecast(lat: Double, long: Double)
    case searchLocation(id: String)
}
extension APIService: TargetType {
    
    var baseURL: URL {
        return URL(string: url)!
    }
    
    var path: String {
           switch self {
           case .getWeather:
               return "/weather"
           case .getListWeatherForecast:
               return "/forecast"
           case .searchLocation:
               return "/weather"
           case .getWeatherByCountaryName:
                return "/weather"
        }
       }

       // Here we specify which method our calls should use.
       var method: Moya.Method {
           switch self {
           case .getWeather:
               return .get
           case .getListWeatherForecast:
               return .get
           case .searchLocation:
               return .get
           case .getWeatherByCountaryName:
            return .get
        }
       }
    // for unit test
    var sampleData: Data {
        return Data()
    }
    
//    var sampleData: Data {
//        switch self {
//        case .items:
//            // Provided you have a file named accounts.json in your bundle.
//            guard let url = Bundle.main.url(forResource: "items", withExtension: "json"),
//                let data = try? Data(contentsOf: url) else {
//                    return Data()
//            }
//            return data
//
//        default:
//            guard let url = Bundle.main.url(forResource: "items", withExtension: "json"),
//                let data = try? Data(contentsOf: url) else {
//                    return Data()
//            }
//            return data
//        }
//    }
//    exclude=hourly,daily
   var task: Task {
           switch self {
           case let .getWeather(lat, lon):
            let parameters: [String: Any] = ["lat": lat, "lon": lon, "APPID": apiKey, "units": "metric"]
               return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
           case let .getListWeatherForecast(lat, lon):
            let parameters: [String: Any] = ["lat": lat, "lon": lon, "APPID": apiKey, "units": "metric"]
               return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
           case let .searchLocation(id):
            let parameters: [String: Any] = ["q" : id ,"APPID": apiKey, "units": "metric"]
               return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
           case .getWeatherByCountaryName:
            let parameters: [String: Any] = ["q": defaultCountry, "APPID": apiKey, "units": "metric"]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
       }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
