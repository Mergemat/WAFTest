//
//  City.swift
//  WAFTest
//
//  Created by baga on 1.09.2021.
//

import Foundation

let conditionKeys = [
    "clear": "ясно",
    "partly-cloudy": "малооблачно",
    "cloudy": "облачно с прояснениями",
    "overcast": "пасмурно",
    "drizzle": "морось",
    "light-rain": "небольшой дождь",
    "rain": "дождь",
    "moderate-rain": "умеренно сильный дождь",
    "heavy-rain": "сильный дождь",
    "continuous-heavy-rain": "длительный сильный дождь",
    "showers": "ливень",
    "wet-snow": "дождь со снегом",
    "light-snow": "небольшой снег",
    "snow": "снег",
    "snow-showers": "снегопад",
    "hail": "град",
    "thunderstorm": "гроза",
    "thunderstorm-with-rain": "дождь с грозой",
    "thunderstorm-with-hail": "гроза с градом"
]

struct City: Codable {
    var name: String?
    var fact: Fact
    var forecasts: [Forecast]
    enum CodingKeys: String, CodingKey {
        case fact
        case forecasts
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fact = try container.decode(Fact.self, forKey: .fact)
        forecasts = try container.decode([Forecast].self, forKey: .forecasts)
    }
}

struct Fact: Codable {
    var temp_avg: Int?
    var temp: Int?
    var feels_like: Int
    var icon: String
}

struct Forecast: Codable {
    var date: String
    var parts: Dictionary<String, Fact>
}
