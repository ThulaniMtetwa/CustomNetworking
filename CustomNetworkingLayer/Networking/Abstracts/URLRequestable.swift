import Foundation

enum APIConfig {
    
    static var baseUrl: String { "jsonplaceholder.typicode.com" }
    static var apiToken: String { "" }
}

protocol URLRequestable {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var apiToken: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var requestBody: Encodable? { get }
    var request: URLRequest? { get }
    var mockFile: String? { get }
}

extension URLRequestable {
    var scheme: String { return "https" }
    
    var baseURL: String { return APIConfig.baseUrl }
    
    var apiToken: String { "" }
    
    var headers: [String: String]? {
        return ["Accept":"*/*",
                "Content-type":"application/json; charset=UTF-8"
        ]
    }
    
    var request: URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host =  baseURL
        urlComponents.path = path
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers
        if !apiToken.isEmpty {
            urlRequest.addValue("\(apiToken)", forHTTPHeaderField: "Authorization")
        }
        if let body = requestBody?.encode() {
            urlRequest.httpBody = body
        }
        
        return urlRequest
    }
    var mockFile: String? { nil }
    
    var queryItems: [URLQueryItem]? { return nil } // Otherwise [URLQueryItem(name: "paramKey", value: paramValue)]
}


protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T
}

extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(type, from: data)
            
            return decodedObject
        } catch {
            fatalError("Failed to decode loaded JSON")
        }
    }
}
