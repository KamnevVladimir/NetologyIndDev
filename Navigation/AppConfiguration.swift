//
//  AppConfiguration.swift
//  Navigation
//
//  Created by Владимир Камнев on 13.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

enum AppConfiguration {
    case peopleURL(String)
    case starshipsURL(String)
    case planetsURL(String)
    
    static func getArrayURL() -> [AppConfiguration] {
        return [AppConfiguration.peopleURL("https://swapi.dev/api/people/8"),
                AppConfiguration.starshipsURL("https://swapi.dev/api/starships/3"),
                AppConfiguration.planetsURL("https://swapi.dev/api/planets/5")]
    }
}
