// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let venuesResponse = try? JSONDecoder().decode(VenuesResponse.self, from: jsonData)

import Foundation

// MARK: - VenuesResponse
struct VenuesResponse: Codable, Sendable {
    let response: [VenueData]

    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}

// MARK: - Response
public struct VenueData: Codable, Sendable {
    public let id: Int?
    public let name: String?
    public let address: String?
    public let city: String?
    public let country: String?
    public let capacity: Int?
    let surface: String?
    public let image: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case address = "address"
        case city = "city"
        case country = "country"
        case capacity = "capacity"
        case surface = "surface"
        case image = "image"
    }
}


func getDummyVenueData()-> [VenueData]{
    
    let st = """
{
   
    "response": [
        {
            "id": 1755,
            "name": "Stadion Nairi",
            "address": null,
            "city": "Yerevan",
            "country": "Armenia",
            "capacity": 6800,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/1755.png"
        },
        {
            "id": 19103,
            "name": "Gandzasar Stadium",
            "address": "M-2",
            "city": "Kapan",
            "country": "Armenia",
            "capacity": 3500,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/19103.png"
        },
        {
            "id": 121,
            "name": "Vazgen Sargsyan anvan Hanrapetakan Marzadasht",
            "address": "ul. Nar-Dos",
            "city": "Yerevan",
            "country": "Armenia",
            "capacity": 14530,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/121.png"
        },
        {
            "id": 119,
            "name": "Urartu Stadium",
            "address": "ul. Al. Manukian, Malatia-Sebastia",
            "city": "Yerevan",
            "country": "Armenia",
            "capacity": 5000,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/119.png"
        },
        {
            "id": 120,
            "name": "Yerevan Football Academy",
            "address": "Acharyan 35/31, Avan",
            "city": "Yerevan",
            "country": "Armenia",
            "capacity": 1500,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/120.png"
        },
        {
            "id": 10510,
            "name": "Vanadzor Football Academy",
            "address": null,
            "city": "Vanadzor",
            "country": "Armenia",
            "capacity": 1500,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/10510.png"
        },
        {
            "id": 2479,
            "name": "Gyumri City Stadium",
            "address": "Ozanyan Str. 6",
            "city": "Gyumri",
            "country": "Armenia",
            "capacity": 3500,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/2479.png"
        },
        {
            "id": 10489,
            "name": "Kasakhi Marzik Stadium",
            "address": "Linch Street",
            "city": "Ashtarak",
            "country": "Armenia",
            "capacity": 3600,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/10489.png"
        },
        {
            "id": 2481,
            "name": "Sports Complex Dzoraghbyur",
            "address": null,
            "city": "Dzoraghbyur",
            "country": "Armenia",
            "capacity": 1000,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/2481.png"
        },
        {
            "id": 4653,
            "name": "Banants-3",
            "address": "ul. Jivani, Malatia-Sebastia",
            "city": "Yerevan",
            "country": "Armenia",
            "capacity": 1500,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/4653.png"
        },
        {
            "id": 2482,
            "name": "Banants Artificial Field",
            "address": "ul. Al. Manukian, Malatia-Sebastia",
            "city": "Yerevan",
            "country": "Armenia",
            "capacity": 2000,
            "surface": "artificial turf",
            "image": "https://media-4.api-sports.io/football/venues/2482.png"
        },
        {
            "id": 2483,
            "name": "Erebuni",
            "address": "Davit Bek Street 71",
            "city": "Yerevan",
            "country": "Armenia",
            "capacity": 544,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/2483.png"
        },
        {
            "id": 2484,
            "name": "Kapan Artificial Pitch",
            "address": "Kapan Industrial Zone",
            "city": "Kapan",
            "country": "Armenia",
            "capacity": 1000,
            "surface": "artificial turf",
            "image": "https://media-4.api-sports.io/football/venues/2484.png"
        },
        {
            "id": 2480,
            "name": "Pyunik Training Centre",
            "address": "Tsitsernakaberd Highway",
            "city": "Yerevan",
            "country": "Armenia",
            "capacity": 2000,
            "surface": "artificial turf",
            "image": "https://media-4.api-sports.io/football/venues/2480.png"
        },
        {
            "id": 2478,
            "name": "Vanadzor Stadium",
            "address": null,
            "city": "Vanadzor",
            "country": "Armenia",
            "capacity": 6000,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/2478.png"
        },
        {
            "id": 2657,
            "name": "Kotaik",
            "address": null,
            "city": "Abovian",
            "country": "Armenia",
            "capacity": 5500,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/2657.png"
        },
        {
            "id": 8942,
            "name": "Pyunik Training Centre",
            "address": "Tsitsernakaberd Highway",
            "city": "Yerevan",
            "country": "Armenia",
            "capacity": 2000,
            "surface": "artificial turf",
            "image": "https://media-4.api-sports.io/football/venues/8942.png"
        },
        {
            "id": 4649,
            "name": "Kasakhi Marzik",
            "address": null,
            "city": "Ashtarak",
            "country": "Armenia",
            "capacity": 2800,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/4649.png"
        },
        {
            "id": 4651,
            "name": "UWC Dilijan",
            "address": "Getapnya Str. 19",
            "city": "Dilijan",
            "country": "Armenia",
            "capacity": 1500,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/4651.png"
        },
        {
            "id": 19915,
            "name": "Vayk Stadium",
            "address": "Yeritasardakan Street",
            "city": "Vayk",
            "country": "Armenia",
            "capacity": 2000,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/19915.png"
        },
        {
            "id": 8943,
            "name": "Sports Complex Dzoraghbyur",
            "address": null,
            "city": "Dzoraghbyur",
            "country": "Armenia",
            "capacity": 1000,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/8943.png"
        },
        {
            "id": 4654,
            "name": "Kotaik Stadium",
            "address": "Nairyan Street",
            "city": "Abovian",
            "country": "Armenia",
            "capacity": 5500,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/4654.png"
        },
        {
            "id": 4655,
            "name": "Charentsavan City Stadium",
            "address": null,
            "city": "Charentsavan",
            "country": "Armenia",
            "capacity": 5000,
            "surface": "artificial turf",
            "image": "https://media-4.api-sports.io/football/venues/4655.png"
        },
        {
            "id": 7464,
            "name": "Mika",
            "address": "41 Manandyan Str.",
            "city": "Yerevan",
            "country": "Armenia",
            "capacity": 7140,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/7464.png"
        },
        {
            "id": 7466,
            "name": "Stadion Ayg",
            "address": null,
            "city": null,
            "country": "Armenia",
            "capacity": 2000,
            "surface": "artificial turf",
            "image": "https://media-4.api-sports.io/football/venues/7466.png"
        },
        {
            "id": 4652,
            "name": "Sisian Stadium",
            "address": "Khanjyan",
            "city": "Sisian",
            "country": "Armenia",
            "capacity": 1000,
            "surface": "grass",
            "image": "https://media-4.api-sports.io/football/venues/4652.png"
        }
    ]
}
"""
    do{
        
        let data: VenuesResponse? = try?   st.toObject()
        
        
        return data?.response ?? []
    }
    
}
