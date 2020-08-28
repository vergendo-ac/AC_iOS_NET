//
// ReconstructedCity.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct ReconstructedCity: Codable { 


    public var id: Int
    public var name: String
    public var countryName: String
    public var gps: ReconstructedCityGps

    public init(id: Int, name: String, countryName: String, gps: ReconstructedCityGps) {
        self.id = id
        self.name = name
        self.countryName = countryName
        self.gps = gps
    }

}