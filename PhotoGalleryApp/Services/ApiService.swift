//
//  ApiService.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 19/08/2023.
//

import Foundation
import Combine

class ApiService {
    // private let apiUrl = "https://photo-gallery-api-59f6baae823c.herokuapp.com/api"
    private let apiUrl = "http://localhost:8080/api"

    func createUser(user: User, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "\(apiUrl)/users/add")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            //request.httpBody = try JSONSerialization.data(withJSONObject: user)
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error)")
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                completion(.failure(NSError(domain: "Invalid response", code: 1, userInfo: nil)))
                return
            }

            if httpResponse.statusCode != 201 {
                print("HTTP status code: \(httpResponse.statusCode)")
                completion(.failure(NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)))
                return
            }

            guard let data = data else {
                print("No data received")
                completion(.failure(NSError(domain: "No data received", code: 1, userInfo: nil)))
                return
            }

            completion(.success(data))
        }

        task.resume()
    }

    func login(user: User, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "\(apiUrl)/users/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error)")
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                completion(.failure(NSError(domain: "Invalid response", code: 1, userInfo: nil)))
                return
            }

            if httpResponse.statusCode != 200 {
                print("HTTP status code: \(httpResponse.statusCode)")
                completion(.failure(NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)))
                return
            }

            guard let data = data else {
                print("No data received")
                completion(.failure(NSError(domain: "No data received", code: 1, userInfo: nil)))
                return
            }

            completion(.success(data))
        }

        task.resume()
    }

    func getImages(userLogin: String, category: String) -> AnyPublisher<[ImageResponse], Error> {
        // Construct your API URL
        let url = URL(string: "\(apiUrl)/images/\(userLogin)/\(category)")!

        // Create a URLRequest
        let request = URLRequest(url: url)
        // Configure request as needed (e.g., set HTTP headers, HTTP method, etc.)

        // Use URLSession to fetch the data
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { $0 as Error }
            .map { data, _ in
                //print(String(data: data, encoding: .utf8) ?? "")
                //print(Date())
                return data
            }
            .decode(type: [ImageResponse].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
