//
//  Planet.swift
//  Navigation
//
//  Created by Владимир Камнев on 14.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct Planet: Decodable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let residents: [String]
    let films: [String]
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter = "diameter"
        case climate = "climate"
        case gravity = "gravity"
        case residents = "residents"
        case films = "films"
    }
}

struct Resident: Decodable {
    let name: String
}

struct Film: Decodable {
    let title: String
}
