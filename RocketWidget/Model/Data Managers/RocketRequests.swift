//
//  RocketRequests.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 01.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Foundation


fileprivate let apiHost = "https://rocketbank.ru/api/v5/"

fileprivate let urlSession = URLSession.shared

fileprivate func genTimeAndSig() -> (String, String) {
    let currentTimeString = NSDate().timeIntervalSince1970.stringValue
    return (currentTimeString, "0Jk211uvxyyYAFcSSsBK3+etfkDPKMz6asDqrzr+f7c=_\(currentTimeString)_dossantos".md5Value)
}

fileprivate let os = "iOS 11.4.8.8"
fileprivate let device = "iPhone X Millenium Edition 512GB Space Gray"

fileprivate func makeHeaders(deviceId: String, token: String) -> [String: String] {
    let (now, sig) = genTimeAndSig()
    let headers = [
        "x-app-version": "4.9.11",
        "x-device-id": deviceId,
        "x-device-os": os,
        "x-device-type": device,
        "x-time": now,
        "x-sig": sig,
        "Host": "rocketbank.ru",
        "Connection": "Keep-Alive",
        "Accept-Encoding": "gzip",
        "User-Agent": "rocketbank/94 CFNetwork/811.5.4 Darwin/16.7.0",
        "Authorization": "Token token=\(token)",
    ]
    
    return headers
}


class RocketRequests {
    static let shared = RocketRequests()
    
    var userConfiguration = UserConfiguration()

    func widget(withCompletion completion: @escaping (WidgetOrResponse?, String?) -> Void) {
        let url = URL(string: "\(apiHost)\(Methods.widget.rawValue)")!
        let request = NSMutableURLRequest(url: url)
        for (key, value) in makeHeaders(deviceId: userConfiguration.deviceId, token: userConfiguration.widgetToken) {
            request.addValue(value, forHTTPHeaderField: key)
        }
        request.httpMethod = "GET"
        let task = urlSession.dataTask(with: request as URLRequest) { (data, response, requestError) in
            guard requestError == nil else {
                completion(nil, String(describing: requestError))
                return
            }
            guard let data = data else {  // can it ever happen?
                completion(nil, "No data! WTF?")  // TODO: - Log this stuff!
                return
            }
            // TODO: - logging
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, "Eroro in response convert!")
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let widgetData = try JSONDecoder().decode(Widget.self, from: data)
                    completion(WidgetOrResponse.widget(widgetData), nil)
                    return
                } catch {
                    completion(nil, String(describing: error))
                    return
                }
            case 400...499:
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    completion(WidgetOrResponse.response(response), nil)
                    return
                } catch {
                    completion(nil, String(describing: error))
                    return
                }
            default: // TODO: - LOG THIS STUFF AND SHOW AN ERROR
                print("eroro! not matchig response code")
                completion(nil, String(describing: response))
                /*
                 print(request.allHTTPHeaderFields)
                 print(String(data: data, encoding: .utf8))
                 */
            }
        }
        task.resume()
    }
}
