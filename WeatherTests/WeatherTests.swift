//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Viktor Vilkhovyi on 11/20/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_city_json() {
        let expectation = self.expectation(description: "Parse City Json")
        
        let city = "Kiev"
        
        Server.whatIsTheWeatherIn(city) { data, error in
            XCTAssertTrue(error == nil, error!.localizedDescription)
            
            guard let json = data?.json else {
                fatalError("Failed to recive Weather JSON")
            }
            
            if let cityId = json["id"] as? Int {
                print(cityId)
            }
            
            if let weather = (json["weather"] as? [Any])?.first as? JSONDictionary,
                let desc = weather["description"] as? String,
                let icon = weather["icon"] as? String {
                print("Weather desc: \(desc) and Icon: \(icon)")
            }
            
            if let main = json["main"] as? JSONDictionary, let temperature =  main["temp"] as? Int {
                print("Temperature \(temperature)")
            }
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 30)
    }
    
    func test_city_decode() {
        let expectation = self.expectation(description: "Decode City Data")
        
        let city = "Kiev"
        
        Server.whatIsTheWeatherIn(city) { data, error in
            XCTAssertTrue(error == nil, error!.localizedDescription)
    
            guard let data = data, let city = try? JSONDecoder().decode(CityMock.self, from: data) else {
                fatalError("Failed To Decode City")
            }
            
            guard city.weather.count > 0 else {
                fatalError("Weather info is empty")
            }
            
            let weather = city.weather[0]
            
            print("Weather Forecast is the next: \(weather.desc)")
            
            print("Temperature Main is the next: \(city.main.temp)")
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 30)
    }
    
    func test_json_weather_for_several_cities() {
        let expectation = self.expectation(description: "Cities JSON for ids")
        
        Server.whatIsTheWeatherInCities(ids: "524901,703448,2643743") { data, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            
            
            guard let cities = data?.json?["list"] as? [Any] else {
                fatalError("Failed to get list of cities")
            }
            
            print(cities.first.debugDescription)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 30)
    }
    
    func test_decode_weather_for_several_cities() {
        let expectation = self.expectation(description: "Cities JSON for ids")
        
        Server.whatIsTheWeatherInCities(ids: "524901,703448,2643743") { data, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            
            guard let data = data, let cities = try? JSONDecoder().decode(CitiesMock.self, from: data) else {
                fatalError("Failed to receive data from the server")
            }
            
            guard cities.cnt > 0 else {
                fatalError("List of Decoded cities is empty")
            }
            
            guard let city = cities.list.first else {
                fatalError("Failed to read list of cities")
            }
            
            let weather = city.weather
            print("Weather Desccription: \(weather[0].desc) ")
            
            let main = city.main
            print("Weather Temperature: \(main.temp)")
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 30)
    }

}
