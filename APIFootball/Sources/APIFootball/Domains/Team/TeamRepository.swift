//
//  TeamRepository.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

import Foundation
import EasyXConnect


public protocol ITeamRepository:Actor{
    func getTeamByID(id:Int)async throws -> [TeamsResponse]
    func getCountryList()async->[TeamsResponse]
    func getCountryById(id:Int)async->TeamsResponse?
    func getCountryByName(name:String)async->TeamsResponse?
    func getTeamSquardsByTeamID(id:Int)async throws ->[SquadPlayer]
}

actor TeamRepository: ITeamRepository{
    
    let client: ExHttpConnect
    
    init(client: ExHttpConnect) {
        self.client = client
    }
    
    func getTeamByID(id: Int) async throws -> [TeamsResponse]{
    
        do{
            var list: [TeamsResponse] = []
            
            let query = ["id": "\(id)"]
            
            let res: AppResponse<TeamDetailsResponse> = try await client.get("teams", headers: [:], query: query)
            
            if let l = res.payload?.response{
                list = l
            }
            return list
        }
    }
    
    func getCountryList() async ->[TeamsResponse] {
        do{
            var list: [TeamsResponse] = []
            list = getValidCountryList()
       
            return list
        }
    }
    
    
    func getCountryById(id: Int) async -> TeamsResponse? {
        var list: [TeamsResponse] = []
        list = getValidCountryList()
        
        return list.first { $0.team.id == id}
        
    }
    
    func getCountryByName(name: String) async -> TeamsResponse? {
        var list: [TeamsResponse] = []
        list = getValidCountryList()
        return list.first { $0.team.name.lowercased() == name.lowercased()}
    }
    
    
    func getTeamSquardsByTeamID(id: Int) async throws -> [SquadPlayer] {
        do{
            var list:[SquadPlayer] = []
            
            let query:[String:String] = ["team": "\(id)"]
            
            
            let res:AppResponse<TeamSquadsResponse> = try await client.get("players/squads", headers: [:], query: query)
            
            if let l = res.payload?.response.first?.players{
                list = l
            }
            return list
        }
    }
    
    
    
    
}


func getValidCountryList()->[TeamsResponse]{
    
    let js  = """
{
  "response": [
    {
      "team": {
        "id": 778,
        "name": "Albania",
        "code": "ALB",
        "country": "Albania",
        "founded": 1930,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/778.png"
      },
      "venue": {
        "id": 18855,
        "name": "Air Albania Stadium",
        "address": "Bulevardi Deshmoret e Kombit",
        "city": "Tirana",
        "capacity": 22000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/18855.png"
      }
    },
    {
      "team": {
        "id": 1532,
        "name": "Algeria",
        "code": "ALG",
        "country": "Algeria",
        "founded": 1962,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1532.png"
      },
      "venue": {
        "id": 5,
        "name": "Stade du 5 Juillet 1962",
        "address": "Lotissement Benhadaddi, Villa 12B, Chéraga",
        "city": "Algiers",
        "capacity": 80200,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/5.png"
      }
    },
    {
      "team": {
        "id": 1110,
        "name": "Andorra",
        "code": "AND",
        "country": "Andorra",
        "founded": 1994,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1110.png"
      },
      "venue": {
        "id": 2618,
        "name": "Estadi Nacional",
        "address": "Baixada de Molí 31-35",
        "city": "Andorra la Vella",
        "capacity": 3306,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/2618.png"
      }
    },
    {
      "team": {
        "id": 1529,
        "name": "Angola",
        "code": "ANG",
        "country": "Angola",
        "founded": 1979,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1529.png"
      },
      "venue": {
        "id": 7135,
        "name": "Estádio Nacional de OMBAKA",
        "address": "Bairro da Taka",
        "city": "Benguela",
        "capacity": 35000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/7135.png"
      }
    },
    {
      "team": {
        "id": 26,
        "name": "Argentina",
        "code": "ARG",
        "country": "Argentina",
        "founded": 1893,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/26.png"
      },
      "venue": {
        "id": 19570,
        "name": "Estadio Mâs Monumental",
        "address": "Avenida Presidente José Figueroa Alcorta 7597, Núñez",
        "city": "Capital Federal, Ciudad de Buenos Aires",
        "capacity": 83214,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/19570.png"
      }
    },
    {
      "team": {
        "id": 1094,
        "name": "Armenia",
        "code": "ARM",
        "country": "Armenia",
        "founded": 1992,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1094.png"
      },
      "venue": {
        "id": 121,
        "name": "Vazgen Sargsyan anvan Hanrapetakan Marzadasht",
        "address": "ul. Nar-Dos",
        "city": "Yerevan",
        "capacity": 14530,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/121.png"
      }
    },
    {
      "team": {
        "id": 8232,
        "name": "Nacional",
        "code": null,
        "country": "Aruba",
        "founded": null,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/8232.png"
      },
      "venue": {
        "id": null,
        "name": null,
        "address": null,
        "city": null,
        "capacity": null,
        "surface": null,
        "image": null
      }
    },
    {
      "team": {
        "id": 20,
        "name": "Australia",
        "code": "AUS",
        "country": "Australia",
        "founded": 1961,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/20.png"
      },
      "venue": {
        "id": 20322,
        "name": "Accor Stadium",
        "address": "Edwin Flack Avenue",
        "city": "Sydney",
        "capacity": 83600,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/20322.png"
      }
    },
    {
      "team": {
        "id": 775,
        "name": "Austria",
        "code": "AUS",
        "country": "Austria",
        "founded": 1904,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/775.png"
      },
      "venue": {
        "id": 1967,
        "name": "Ernst-Happel-Stadion",
        "address": "Meiereistraße 7",
        "city": "Wien",
        "capacity": 50865,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1967.png"
      }
    },
    {
      "team": {
        "id": 1096,
        "name": "Azerbaijan",
        "code": null,
        "country": "Azerbaidjan",
        "founded": 1992,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1096.png"
      },
      "venue": {
        "id": 2607,
        "name": "Bakı Olimpiya Stadionu",
        "address": "Boyuk Shor",
        "city": "Baku",
        "capacity": 68700,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/2607.png"
      }
    },
    {
      "team": {
        "id": 1547,
        "name": "Bahrain",
        "code": "BAH",
        "country": "Bahrain",
        "founded": 1957,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1547.png"
      },
      "venue": {
        "id": 159,
        "name": "Stād al-Bahrayn al-Watanī (Bahrain National Stadium)",
        "address": "Muharraq Avenue",
        "city": "Riffa",
        "capacity": 35580,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/159.png"
      }
    },
    {
      "team": {
        "id": 1560,
        "name": "Bangladesh",
        "code": "BAN",
        "country": "Bangladesh",
        "founded": 1972,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1560.png"
      },
      "venue": {
        "id": 3798,
        "name": "Bangabandhu National Stadium",
        "address": "Abdul Gani Road, Motijheel",
        "city": "Dhaka",
        "capacity": 36000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/3798.png"
      }
    },
    {
      "team": {
        "id": 5527,
        "name": "Barbados",
        "code": null,
        "country": "Barbados",
        "founded": 1910,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/5527.png"
      },
      "venue": {
        "id": 4152,
        "name": "Wildey Turf (Sir Garfield Sobers Complex)",
        "address": "Wildey, St. Michael",
        "city": "Bridgetown",
        "capacity": 2000,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/4152.png"
      }
    },
    {
      "team": {
        "id": 1100,
        "name": "Belarus",
        "code": null,
        "country": "Belarus",
        "founded": 1989,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1100.png"
      },
      "venue": {
        "id": 2606,
        "name": "Stadyen Dynama",
        "address": "ul. Kirova 8/2",
        "city": "Minsk",
        "capacity": 41024,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/2606.png"
      }
    },
    {
      "team": {
        "id": 1,
        "name": "Belgium",
        "code": "BEL",
        "country": "Belgium",
        "founded": 1895,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1.png"
      },
      "venue": {
        "id": 173,
        "name": "Stade Roi Baudouin",
        "address": "Avenue de Marathon 135/2, Laken",
        "city": "Brussel",
        "capacity": 50093,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/173.png"
      }
    },
    {
      "team": {
        "id": 5528,
        "name": "Belize",
        "code": "BEL",
        "country": "Belize",
        "founded": 1980,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/5528.png"
      },
      "venue": {
        "id": 4153,
        "name": "FFB Field",
        "address": "Avenii de Plage",
        "city": "Belmopán",
        "capacity": 5000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/4153.png"
      }
    },
    {
      "team": {
        "id": 1516,
        "name": "Benin",
        "code": "BEN",
        "country": "Benin",
        "founded": 1962,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1516.png"
      },
      "venue": {
        "id": 197,
        "name": "Stade de l'Amitié",
        "address": "RN3",
        "city": "Cotonou",
        "capacity": 35000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/197.png"
      }
    },
    {
      "team": {
        "id": 5158,
        "name": "Bermuda",
        "code": null,
        "country": "Bermuda",
        "founded": 1928,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/5158.png"
      },
      "venue": {
        "id": 3900,
        "name": "Bermuda National Stadium",
        "address": "Frog Lane, Parsons Road",
        "city": "Hamilton, Devonshire Parish",
        "capacity": 8500,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/3900.png"
      }
    },
    {
      "team": {
        "id": 1540,
        "name": "Bhutan",
        "code": "BHU",
        "country": "Bhutan",
        "founded": 1983,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1540.png"
      },
      "venue": {
        "id": 4092,
        "name": "Changlimithang National Stadium",
        "address": "Chang Lam Road, Changlimithang",
        "city": "Thimphu",
        "capacity": 15000,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/4092.png"
      }
    },
    {
      "team": {
        "id": 2381,
        "name": "Bolivia",
        "code": "BOL",
        "country": "Bolivia",
        "founded": 1925,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/2381.png"
      },
      "venue": {
        "id": 198,
        "name": "Estadio Hernando Siles",
        "address": "Avenida Saavedra, Miraflores",
        "city": "La Paz",
        "capacity": 45000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/198.png"
      }
    },
    {
      "team": {
        "id": 1113,
        "name": "Bosnia & Herzegovina",
        "code": "BOS",
        "country": "Bosnia",
        "founded": 1992,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1113.png"
      },
      "venue": {
        "id": 2186,
        "name": "Stadion Bilino Polje",
        "address": "Bulevar Kulina Bana bb",
        "city": "Zenica",
        "capacity": 15292,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/2186.png"
      }
    },
    {
      "team": {
        "id": 1520,
        "name": "Botswana",
        "code": "BOT",
        "country": "Botswana",
        "founded": 1970,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1520.png"
      },
      "venue": {
        "id": 203,
        "name": "Botswana National Stadium",
        "address": "Notwane Road",
        "city": "Gaborone",
        "capacity": 22500,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/203.png"
      }
    },
    {
      "team": {
        "id": 6,
        "name": "Brazil",
        "code": "BRA",
        "country": "Brazil",
        "founded": 1914,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/6.png"
      },
      "venue": {
        "id": 204,
        "name": "Estadio Jornalista Mário Filho (Maracanã)",
        "address": "Rua Professor Eurico Rabelo, Maracanã",
        "city": "Rio de Janeiro, Rio de Janeiro",
        "capacity": 78838,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/204.png"
      }
    },
    {
      "team": {
        "id": 1103,
        "name": "Bulgaria",
        "code": "BUL",
        "country": "Bulgaria",
        "founded": 1923,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1103.png"
      },
      "venue": {
        "id": 1912,
        "name": "Stadion Vasil Levski",
        "address": "bul. Evlogi Georgiev 38",
        "city": "Sofia",
        "capacity": 43632,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1912.png"
      }
    },
    {
      "team": {
        "id": 1502,
        "name": "Burkina Faso",
        "code": "BUR",
        "country": "Burkina-Faso",
        "founded": 1960,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1502.png"
      },
      "venue": {
        "id": 306,
        "name": "Stade du 4 Août",
        "address": "Rue 9.04",
        "city": "Ouagadougou",
        "capacity": 60000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/306.png"
      }
    },
    {
      "team": {
        "id": 1528,
        "name": "Burundi",
        "code": "BUR",
        "country": "Burundi",
        "founded": 1948,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1528.png"
      },
      "venue": {
        "id": 307,
        "name": "Stade Intwari",
        "address": "Avenue Muyinga",
        "city": "Bujumbura",
        "capacity": 22000,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/307.png"
      }
    },
    {
      "team": {
        "id": 1543,
        "name": "Cambodia",
        "code": null,
        "country": "Cambodia",
        "founded": 1933,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1543.png"
      },
      "venue": {
        "id": 20324,
        "name": "Olympic Stadium",
        "address": "Monireth Boulevard",
        "city": "Phnom Penh",
        "capacity": 70000,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/20324.png"
      }
    },
    {
      "team": {
        "id": 1530,
        "name": "Cameroon",
        "code": "CAM",
        "country": "Cameroon",
        "founded": 1959,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1530.png"
      },
      "venue": {
        "id": 308,
        "name": "Stade Omnisport Ahmadou Ahidjo",
        "address": null,
        "city": "Yaoundé",
        "capacity": 38509,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/308.png"
      }
    },
    {
      "team": {
        "id": 1717,
        "name": "Canada W",
        "code": null,
        "country": "Canada",
        "founded": 1912,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1717.png"
      },
      "venue": {
        "id": null,
        "name": null,
        "address": null,
        "city": null,
        "capacity": null,
        "surface": null,
        "image": null
      }
    },
    {
      "team": {
        "id": 1977,
        "name": "Chile W",
        "code": null,
        "country": "Chile",
        "founded": 1895,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1977.png"
      },
      "venue": {
        "id": null,
        "name": null,
        "address": null,
        "city": null,
        "capacity": null,
        "surface": null,
        "image": null
      }
    },
    {
      "team": {
        "id": 1566,
        "name": "China",
        "code": "CHI",
        "country": "China",
        "founded": 1924,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1566.png"
      },
      "venue": {
        "id": 347,
        "name": "Beijing National Stadium",
        "address": null,
        "city": "Beijing",
        "capacity": 91000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/347.png"
      }
    },
    {
      "team": {
        "id": 1557,
        "name": "Chinese Taipei",
        "code": null,
        "country": "Chinese-Taipei",
        "founded": 1936,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1557.png"
      },
      "venue": {
        "id": 3890,
        "name": "Kaohsiung National Stadium",
        "address": "Jhonghai Road 500, Zuoying District",
        "city": "Gaoxiong",
        "capacity": 55000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/3890.png"
      }
    },
    {
      "team": {
        "id": 8,
        "name": "Colombia",
        "code": "COL",
        "country": "Colombia",
        "founded": 1924,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/8.png"
      },
      "venue": {
        "id": 366,
        "name": "Estadio Metropolitano Roberto Meléndez",
        "address": "Intersección de la Avenida Circunvalar con la Calle 45",
        "city": "Barranquilla",
        "capacity": 49612,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/366.png"
      }
    },
    {
      "team": {
        "id": 1508,
        "name": "Congo DR",
        "code": "CON",
        "country": "Congo-DR",
        "founded": 1919,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1508.png"
      },
      "venue": {
        "id": 391,
        "name": "Stade des Martyrs de la Pentecôte",
        "address": "Boulevard Triomphal, Lingwala",
        "city": "Kinshasa",
        "capacity": 100000,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/391.png"
      }
    },
    {
      "team": {
        "id": 1508,
        "name": "Congo DR",
        "code": "CON",
        "country": "Congo-DR",
        "founded": 1919,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1508.png"
      },
      "venue": {
        "id": 391,
        "name": "Stade des Martyrs de la Pentecôte",
        "address": "Boulevard Triomphal, Lingwala",
        "city": "Kinshasa",
        "capacity": 100000,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/391.png"
      }
    },
    {
      "team": {
        "id": 29,
        "name": "Costa Rica",
        "code": "COS",
        "country": "Costa-Rica",
        "founded": 1921,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/29.png"
      },
      "venue": {
        "id": 392,
        "name": "Estadio Nacional de Costa Rica",
        "address": "Avenida Las Americas, La Sabana",
        "city": "San José",
        "capacity": 35100,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/392.png"
      }
    },
    {
      "team": {
        "id": 3,
        "name": "Croatia",
        "code": "CRO",
        "country": "Croatia",
        "founded": 1912,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/3.png"
      },
      "venue": {
        "id": 412,
        "name": "Stadion Maksimir",
        "address": "Maksimirska cesta 128",
        "city": "Zagreb",
        "capacity": 37168,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/412.png"
      }
    },
    {
      "team": {
        "id": 1783,
        "name": "Cuba W",
        "code": null,
        "country": "Cuba",
        "founded": 1924,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1783.png"
      },
      "venue": {
        "id": null,
        "name": null,
        "address": null,
        "city": null,
        "capacity": null,
        "surface": null,
        "image": null
      }
    },
    {
      "team": {
        "id": 5530,
        "name": "Curaçao",
        "code": null,
        "country": "Curaçao",
        "founded": 1921,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/5530.png"
      },
      "venue": {
        "id": 19758,
        "name": "Stadion Ergilio Hato",
        "address": "Corrieweg / Bonamweg 49, Brievengat",
        "city": "Willemstad",
        "capacity": 10000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/19758.png"
      }
    },
    {
      "team": {
        "id": 1106,
        "name": "Cyprus",
        "code": null,
        "country": "Cyprus",
        "founded": 1934,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1106.png"
      },
      "venue": {
        "id": 432,
        "name": "Neo GSP",
        "address": "Pangkiprion Avenue, Strovolos",
        "city": "Levkosía",
        "capacity": 22859,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/432.png"
      }
    },
    {
      "team": {
        "id": 770,
        "name": "Czech Republic",
        "code": "CZE",
        "country": "Czech-Republic",
        "founded": 1901,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/770.png"
      },
      "venue": {
        "id": 19513,
        "name": "epet ARENA",
        "address": "Milady Horákové 1066/98, Letná",
        "city": "Praha",
        "capacity": 20854,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/19513.png"
      }
    },
    {
      "team": {
        "id": 21,
        "name": "Denmark",
        "code": "DEN",
        "country": "Denmark",
        "founded": 1889,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/21.png"
      },
      "venue": {
        "id": 11600,
        "name": "Parken",
        "address": "Øster Allé 50",
        "city": "København",
        "capacity": 38065,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/11600.png"
      }
    },
    {
      "team": {
        "id": 1731,
        "name": "Ecuador W",
        "code": null,
        "country": "Sweden",
        "founded": 1925,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1731.png"
      },
      "venue": {
        "id": null,
        "name": null,
        "address": null,
        "city": null,
        "capacity": null,
        "surface": null,
        "image": null
      }
    },
    {
      "team": {
        "id": 32,
        "name": "Egypt",
        "code": "EGY",
        "country": "Egypt",
        "founded": 1921,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/32.png"
      },
      "venue": {
        "id": 477,
        "name": "Cairo International Stadium",
        "address": "Al-Istad Al-Bahary Street, Nasr City",
        "city": "Cairo",
        "capacity": 74100,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/477.png"
      }
    },
    {
      "team": {
        "id": 5159,
        "name": "El Salvador",
        "code": "SAL",
        "country": "El-Salvador",
        "founded": 1935,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/5159.png"
      },
      "venue": {
        "id": 3284,
        "name": "Estadio Cuscatlán",
        "address": "Calle Antigua a Huizucar",
        "city": "San Salvador",
        "capacity": 45925,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/3284.png"
      }
    },
    {
      "team": {
        "id": 10,
        "name": "England",
        "code": "ENG",
        "country": "England",
        "founded": 1863,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/10.png"
      },
      "venue": {
        "id": 489,
        "name": "Wembley Stadium",
        "address": "Stadium Way, Wembley, Brent",
        "city": "London",
        "capacity": 90000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/489.png"
      }
    },
    {
      "team": {
        "id": 1101,
        "name": "Estonia",
        "code": "EST",
        "country": "Estonia",
        "founded": 1921,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1101.png"
      },
      "venue": {
        "id": 605,
        "name": "A. Le Coq Arena",
        "address": "Asula 4c",
        "city": "Tallinn",
        "capacity": 14405,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/605.png"
      }
    },
    {
      "team": {
        "id": 2995,
        "name": "Eswatini",
        "code": null,
        "country": "Eswatini",
        "founded": 1968,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/2995.png"
      },
      "venue": {
        "id": 1500,
        "name": "Somhlolo National Stadium",
        "address": "MR 103",
        "city": "Lobamba",
        "capacity": 20000,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/1500.png"
      }
    },
    {
      "team": {
        "id": 1506,
        "name": "Ethiopia",
        "code": "ETH",
        "country": "Ethiopia",
        "founded": 1943,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1506.png"
      },
      "venue": {
        "id": 608,
        "name": "Addis Ababa Stadium",
        "address": "Mesqel adebabay",
        "city": "Addis Abeba",
        "capacity": 35000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/608.png"
      }
    },
    {
      "team": {
        "id": 1098,
        "name": "Faroe Islands",
        "code": "FAR",
        "country": "Faroe-Islands",
        "founded": 1979,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1098.png"
      },
      "venue": {
        "id": 2609,
        "name": "Tórsvøllur",
        "address": "R.C. Effersøes gata",
        "city": "Tórshavn, Streymoy",
        "capacity": 6040,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/2609.png"
      }
    },
    {
      "team": {
        "id": 5160,
        "name": "Fiji",
        "code": null,
        "country": "Fiji",
        "founded": 1938,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/5160.png"
      },
      "venue": {
        "id": 19498,
        "name": "HFC Bank Stadium",
        "address": "Laucala Bay Road",
        "city": "Suva",
        "capacity": 10000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/19498.png"
      }
    },
    {
      "team": {
        "id": 1099,
        "name": "Finland",
        "code": "FIN",
        "country": "Finland",
        "founded": 1907,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1099.png"
      },
      "venue": {
        "id": 2608,
        "name": "Helsingin olympiastadion",
        "address": "Paavo Nurmen Tie 1",
        "city": "Helsingfors",
        "capacity": 40682,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/2608.png"
      }
    },
    {
      "team": {
        "id": 2,
        "name": "France",
        "code": "FRA",
        "country": "France",
        "founded": 1919,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/2.png"
      },
      "venue": {
        "id": 631,
        "name": "Stade de France",
        "address": "Rue Jules Rimet",
        "city": "Saint-Denis",
        "capacity": 81338,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/631.png"
      }
    },
    {
      "team": {
        "id": 1503,
        "name": "Gabon",
        "code": "GAB",
        "country": "Gabon",
        "founded": 1962,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1503.png"
      },
      "venue": {
        "id": 688,
        "name": "Stade Omnisport Président Omar Bongo Ondimba",
        "address": null,
        "city": "Libreville",
        "capacity": 40000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/688.png"
      }
    },
    {
      "team": {
        "id": 1492,
        "name": "Gambia",
        "code": "GAM",
        "country": "Gambia",
        "founded": 1952,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1492.png"
      },
      "venue": {
        "id": 689,
        "name": "Independence Stadium",
        "address": null,
        "city": "Bakau",
        "capacity": 25000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/689.png"
      }
    },
    {
      "team": {
        "id": 1104,
        "name": "Georgia",
        "code": "GEO",
        "country": "Georgia",
        "founded": 1990,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1104.png"
      },
      "venue": {
        "id": 691,
        "name": "Boris Paichadze Dinamo Arena",
        "address": "2, Akaki Tsereteli Ave.",
        "city": "Tbilisi",
        "capacity": 54202,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/691.png"
      }
    },
    {
      "team": {
        "id": 25,
        "name": "Germany",
        "code": "GER",
        "country": "Germany",
        "founded": 1900,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/25.png"
      },
      "venue": {
        "id": 694,
        "name": "Olympiastadion Berlin",
        "address": "Olympischer Platz 3",
        "city": "Berlin",
        "capacity": 77116,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/694.png"
      }
    },
    {
      "team": {
        "id": 1504,
        "name": "Ghana",
        "code": "GHA",
        "country": "Ghana",
        "founded": 1957,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1504.png"
      },
      "venue": {
        "id": 759,
        "name": "Ohene Djan Sports Stadium",
        "address": "Malam Awudu Road",
        "city": "Accra",
        "capacity": 35000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/759.png"
      }
    },
    {
      "team": {
        "id": 1093,
        "name": "Gibraltar",
        "code": null,
        "country": "Gibraltar",
        "founded": 1895,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1093.png"
      },
      "venue": {
        "id": 760,
        "name": "Victoria Stadium",
        "address": "Winston Churchill Avenue",
        "city": "Gibraltar",
        "capacity": 5000,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/760.png"
      }
    },
    {
      "team": {
        "id": 1117,
        "name": "Greece",
        "code": "GRE",
        "country": "Greece",
        "founded": 1926,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1117.png"
      },
      "venue": {
        "id": 761,
        "name": "Olympiako Stadio Spyros Louis",
        "address": "37 Kifissias Avenue, Maroussi",
        "city": "Athens",
        "capacity": 71030,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/761.png"
      }
    },
    {
      "team": {
        "id": 4403,
        "name": "Arsenal",
        "code": null,
        "country": "Guadeloupe",
        "founded": null,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/4403.png"
      },
      "venue": {
        "id": null,
        "name": null,
        "address": null,
        "city": null,
        "capacity": null,
        "surface": null,
        "image": null
      }
    },
    {
      "team": {
        "id": 5161,
        "name": "Guatemala",
        "code": null,
        "country": "Guatemala",
        "founded": 1919,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/5161.png"
      },
      "venue": {
        "id": 3901,
        "name": "Estadio Nacional Mateo Flores",
        "address": "11 Avenida",
        "city": "Ciudad de Guatemala",
        "capacity": 29950,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/3901.png"
      }
    },
    {
      "team": {
        "id": 1509,
        "name": "Guinea",
        "code": "GUI",
        "country": "Guinea",
        "founded": 1960,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1509.png"
      },
      "venue": {
        "id": 785,
        "name": "Stade du 28 Septembre",
        "address": "Route de Donka",
        "city": "Conakry",
        "capacity": 35000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/785.png"
      }
    },
    {
      "team": {
        "id": 2386,
        "name": "Haiti",
        "code": "HAI",
        "country": "Haiti",
        "founded": 1904,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/2386.png"
      },
      "venue": {
        "id": 2856,
        "name": "Stade Sylvio Cator",
        "address": "Rue O. Durand",
        "city": "Port-au-Prince",
        "capacity": 15000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/2856.png"
      }
    },
    {
      "team": {
        "id": 4672,
        "name": "Honduras",
        "code": "HON",
        "country": "Honduras",
        "founded": 1951,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/4672.png"
      },
      "venue": {
        "id": 19208,
        "name": "Estadio José de la Paz Herrera Uclés",
        "address": "1A Avenida, Barrio Morazán",
        "city": "Tegucigalpa",
        "capacity": 35000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/19208.png"
      }
    },
    {
      "team": {
        "id": 4460,
        "name": "Hong Kong",
        "code": "HON",
        "country": "Hong-Kong",
        "founded": 1914,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/4460.png"
      },
      "venue": {
        "id": 3385,
        "name": "Hong Kong Stadium",
        "address": "55 Eastern Hospital Road, So Kon Po, Wanchai",
        "city": "Hong Kong",
        "capacity": 40000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/3385.png"
      }
    },
    {
      "team": {
        "id": 769,
        "name": "Hungary",
        "code": "HUN",
        "country": "Hungary",
        "founded": null,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/769.png"
      },
      "venue": {
        "id": 19605,
        "name": "Puskás Aréna",
        "address": "Dózsa György út 5",
        "city": "Budapest",
        "capacity": 67889,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/19605.png"
      }
    },
    {
      "team": {
        "id": 18,
        "name": "Iceland",
        "code": "ICE",
        "country": "Iceland",
        "founded": 1947,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/18.png"
      },
      "venue": {
        "id": 819,
        "name": "Laugardalsvöllur",
        "address": "Reykjavegur",
        "city": "Reykjavík",
        "capacity": 15427,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/819.png"
      }
    },
    {
      "team": {
        "id": 1537,
        "name": "India",
        "code": "IND",
        "country": "India",
        "founded": 1937,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1537.png"
      },
      "venue": {
        "id": 832,
        "name": "Jawaharlal Nehru Stadium",
        "address": "Jawaharlal Nehru Stadium Marg, Lodi Estate",
        "city": "New Delhi",
        "capacity": 78000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/832.png"
      }
    },
    {
      "team": {
        "id": 1571,
        "name": "Indonesia",
        "code": "IND",
        "country": "Indonesia",
        "founded": 1930,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1571.png"
      },
      "venue": {
        "id": 3892,
        "name": "Stadion Utama Gelora Bung Karno",
        "address": "Jalan Stadion Senayan, Senayan",
        "city": "Jakarta",
        "capacity": 88083,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/3892.png"
      }
    },
    {
      "team": {
        "id": 22,
        "name": "Iran",
        "code": "IRA",
        "country": "Iran",
        "founded": 1920,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/22.png"
      },
      "venue": {
        "id": 845,
        "name": "Azadi Stadium",
        "address": "Azadi Stadium Boulevard",
        "city": "Teheran",
        "capacity": 100000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/845.png"
      }
    },
    {
      "team": {
        "id": 1567,
        "name": "Iraq",
        "code": "IRA",
        "country": "Iraq",
        "founded": 1948,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1567.png"
      },
      "venue": {
        "id": 862,
        "name": "Basra Sport City Stadium",
        "address": null,
        "city": "Basra",
        "capacity": 65000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/862.png"
      }
    },
    {
      "team": {
        "id": 771,
        "name": "Northern Ireland",
        "code": null,
        "country": "Northern-Ireland",
        "founded": 1880,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/771.png"
      },
      "venue": {
        "id": 1971,
        "name": "Windsor Park",
        "address": "Donegall Avenue",
        "city": "Belfast",
        "capacity": 18614,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1971.png"
      }
    },
    {
      "team": {
        "id": 1116,
        "name": "Israel",
        "code": null,
        "country": "Israel",
        "founded": 1928,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1116.png"
      },
      "venue": {
        "id": 2610,
        "name": "National Stadium Ramat Gan",
        "address": "26 Bugrashov Street, Ramat Gan",
        "city": "Ramat Gan",
        "capacity": 41583,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/2610.png"
      }
    },
    {
      "team": {
        "id": 768,
        "name": "Italy",
        "code": "ITA",
        "country": "Italy",
        "founded": 1898,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/768.png"
      },
      "venue": {
        "id": 910,
        "name": "Stadio Olimpico",
        "address": "Viale dei Gladiatori, 2 / Via del Foro Italico",
        "city": "Roma",
        "capacity": 68530,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/910.png"
      }
    },
    {
      "team": {
        "id": 1501,
        "name": "Ivory Coast",
        "code": "IVO",
        "country": "Ivory-Coast",
        "founded": 1960,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1501.png"
      },
      "venue": {
        "id": 411,
        "name": "Stade Félix Houphouët-Boigny",
        "address": "Boulevard Lagunaire, Le Plateau",
        "city": "Abidjan",
        "capacity": 45000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/411.png"
      }
    },
    {
      "team": {
        "id": 1785,
        "name": "Jamaica W",
        "code": null,
        "country": "Jamaica",
        "founded": 1910,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1785.png"
      },
      "venue": {
        "id": null,
        "name": null,
        "address": null,
        "city": null,
        "capacity": null,
        "surface": null,
        "image": null
      }
    },
    {
      "team": {
        "id": 12,
        "name": "Japan",
        "code": "JAP",
        "country": "Japan",
        "founded": 1921,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/12.png"
      },
      "venue": {
        "id": 951,
        "name": "National Olympic Stadium",
        "address": "10-2, Kasumigaoka-machi, Shinjuku",
        "city": "Tokyo",
        "capacity": 57363,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/951.png"
      }
    },
    {
      "team": {
        "id": 1548,
        "name": "Jordan",
        "code": "JOR",
        "country": "Jordan",
        "founded": 1949,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1548.png"
      },
      "venue": {
        "id": 988,
        "name": "Amman International Stadium",
        "address": null,
        "city": "Amman",
        "capacity": 25000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/988.png"
      }
    },
    {
      "team": {
        "id": 1095,
        "name": "Kazakhstan",
        "code": "KAZ",
        "country": "Kazakhstan",
        "founded": 1914,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1095.png"
      },
      "venue": {
        "id": 989,
        "name": "Astana Arena",
        "address": "ul. Kabanbai Batyr 45",
        "city": "Nur-Sultan",
        "capacity": 30254,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/989.png"
      }
    },
    {
      "team": {
        "id": 1511,
        "name": "Kenya",
        "code": "KEN",
        "country": "Kenya",
        "founded": 1960,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1511.png"
      },
      "venue": {
        "id": 992,
        "name": "Nyayo National Stadium",
        "address": "Langata Road / Mombasa Road",
        "city": "Nairobi",
        "capacity": 30000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/992.png"
      }
    },
    {
      "team": {
        "id": 1111,
        "name": "Kosovo",
        "code": "SOV",
        "country": "Kosovo",
        "founded": 1946,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1111.png"
      },
      "venue": {
        "id": 1813,
        "name": "Stadiumi Fadil Vokrri",
        "address": null,
        "city": "Pristina",
        "capacity": 13500,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1813.png"
      }
    },
    {
      "team": {
        "id": 1570,
        "name": "Kuwait",
        "code": "KUW",
        "country": "Kuwait",
        "founded": 1952,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1570.png"
      },
      "venue": {
        "id": 1975,
        "name": "Jaber Al-Ahmad International Stadium",
        "address": "Sixth Ring Road, Ardhiyah",
        "city": "Kuwait City",
        "capacity": 60000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1975.png"
      }
    },
    {
      "team": {
        "id": 1554,
        "name": "Kyrgyzstan",
        "code": "KYR",
        "country": "Kyrgyzstan",
        "founded": 1992,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1554.png"
      },
      "venue": {
        "id": 1021,
        "name": "Stadion im. Dolena Omurzakova",
        "address": "ul. Funze",
        "city": "Bishkek",
        "capacity": 23000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1021.png"
      }
    },
    {
      "team": {
        "id": 1558,
        "name": "Laos",
        "code": "LAO",
        "country": "Laos",
        "founded": 1951,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1558.png"
      },
      "venue": {
        "id": 19511,
        "name": "National Stadium KM16",
        "address": "Avenue Kaysone Phomvihane, KM16, Anou",
        "city": "Vientiane",
        "capacity": 25000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/19511.png"
      }
    },
    {
      "team": {
        "id": 1092,
        "name": "Latvia",
        "code": "LAT",
        "country": "Latvia",
        "founded": 1921,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1092.png"
      },
      "venue": {
        "id": 2611,
        "name": "Stadions Skonto",
        "address": "Emīla Melngaiļa 1a",
        "city": "Riga",
        "capacity": 8207,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/2611.png"
      }
    },
    {
      "team": {
        "id": 1551,
        "name": "Lebanon",
        "code": "LEB",
        "country": "Lebanon",
        "founded": 1933,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1551.png"
      },
      "venue": {
        "id": 1025,
        "name": "Camille Chamoun Sports City Stadium",
        "address": "Hafez El-Asad Street, Bir Hassan",
        "city": "Beirut",
        "capacity": 48837,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1025.png"
      }
    },
    {
      "team": {
        "id": 1518,
        "name": "Lesotho",
        "code": "LES",
        "country": "Lesotho",
        "founded": 1932,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1518.png"
      },
      "venue": {
        "id": 1026,
        "name": "Setsoto Stadium",
        "address": "Rantsala",
        "city": "Maseru",
        "capacity": 20000,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/1026.png"
      }
    },
    {
      "team": {
        "id": 1525,
        "name": "Liberia",
        "code": "LIB",
        "country": "Liberia",
        "founded": 1936,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1525.png"
      },
      "venue": {
        "id": 20323,
        "name": "Samuel Kanyon Doe Stadium",
        "address": "Paynesville",
        "city": "Monrovia",
        "capacity": 35000,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/20323.png"
      }
    },
    {
      "team": {
        "id": 1526,
        "name": "Libya",
        "code": "LIB",
        "country": "Libya",
        "founded": 1962,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1526.png"
      },
      "venue": {
        "id": 1028,
        "name": "11 June Stadium",
        "address": null,
        "city": "Tripoli",
        "capacity": 67000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1028.png"
      }
    },
    {
      "team": {
        "id": 1107,
        "name": "Liechtenstein",
        "code": null,
        "country": "Liechtenstein",
        "founded": 1934,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1107.png"
      },
      "venue": {
        "id": 1545,
        "name": "Rheinpark Stadion",
        "address": "Lettstrasse 74",
        "city": "Vaduz",
        "capacity": 7838,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1545.png"
      }
    },
    {
      "team": {
        "id": 1097,
        "name": "Lithuania",
        "code": "LIT",
        "country": "Lithuania",
        "founded": 1922,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1097.png"
      },
      "venue": {
        "id": 2612,
        "name": "S. Dariaus ir S. Girėno stadionas",
        "address": "Ąžuolyno gatvė",
        "city": "Kaunas",
        "capacity": 15315,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/2612.png"
      }
    },
    {
      "team": {
        "id": 1102,
        "name": "Luxembourg",
        "code": null,
        "country": "Luxembourg",
        "founded": 1908,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1102.png"
      },
      "venue": {
        "id": 19604,
        "name": "Stade de Luxembourg",
        "address": "E25",
        "city": "Luxembourg",
        "capacity": 9386,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/19604.png"
      }
    },
    {
      "team": {
        "id": 4767,
        "name": "Mação",
        "code": null,
        "country": "Macao",
        "founded": 1978,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/4767.png"
      },
      "venue": {
        "id": 3611,
        "name": "Macau Olympic Complex Stadium",
        "address": "Avenida do Estádio",
        "city": "Taipa",
        "capacity": 16272,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/3611.png"
      }
    },
    {
      "team": {
        "id": 1105,
        "name": "FYR Macedonia",
        "code": "MAC",
        "country": "Macedonia",
        "founded": 1948,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1105.png"
      },
      "venue": {
        "id": 7136,
        "name": "Telekom Arena",
        "address": "Gradski Park bb",
        "city": "Skopje",
        "capacity": 32580,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/7136.png"
      }
    },
    {
      "team": {
        "id": 1495,
        "name": "Malawi",
        "code": "MAL",
        "country": "Malawi",
        "founded": 1966,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1495.png"
      },
      "venue": {
        "id": 1048,
        "name": "Kamuzu Stadium",
        "address": "Masauk Chipembere Highway",
        "city": "Blantyre",
        "capacity": 40000,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/1048.png"
      }
    },
    {
      "team": {
        "id": 1538,
        "name": "Malaysia",
        "code": "MAL",
        "country": "Malaysia",
        "founded": 1933,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1538.png"
      },
      "venue": {
        "id": 19696,
        "name": "Bukit Jalil National Stadium",
        "address": "Jalan Merah Cagar, Bukit Jalil",
        "city": "Kuala Lumpur",
        "capacity": 87411,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/19696.png"
      }
    },
    {
      "team": {
        "id": 1549,
        "name": "Maldives",
        "code": "MAL",
        "country": "Maldives",
        "founded": 1982,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1549.png"
      },
      "venue": {
        "id": 19656,
        "name": "National Football Stadium (Maldives)",
        "address": "Majeedhee Magu",
        "city": "Malé, North Malé Atoll, Kaafu Atoll",
        "capacity": 11850,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/19656.png"
      }
    },
    {
      "team": {
        "id": 1500,
        "name": "Mali",
        "code": "MAL",
        "country": "Mali",
        "founded": 1960,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1500.png"
      },
      "venue": {
        "id": 1064,
        "name": "Stade 26 Mars",
        "address": "RN6, Sokorodj",
        "city": "Bamako",
        "capacity": 55000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1064.png"
      }
    },
    {
      "team": {
        "id": 1112,
        "name": "Malta",
        "code": "MAL",
        "country": "Malta",
        "founded": 1900,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1112.png"
      },
      "venue": {
        "id": 2614,
        "name": "Ta'Qali National Stadium",
        "address": "Villagg Tas-Snajja&apos;",
        "city": "Ta&apos;Qali",
        "capacity": 17797,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/2614.png"
      }
    },
    {
      "team": {
        "id": 1491,
        "name": "Mauritania",
        "code": "MAU",
        "country": "Mauritania",
        "founded": 1961,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1491.png"
      },
      "venue": {
        "id": 1068,
        "name": "Stade Olympique de Nouakchott",
        "address": "Rue de l&apos;Ambassade du Sénégal",
        "city": "Nouakchott",
        "capacity": 40000,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/1068.png"
      }
    },
    {
      "team": {
        "id": 1497,
        "name": "Mauritius",
        "code": "MAU",
        "country": "Mauritius",
        "founded": 1952,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1497.png"
      },
      "venue": {
        "id": 11301,
        "name": "New George V Stadium",
        "address": "Barry Road",
        "city": "Curepipe",
        "capacity": 6200,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/11301.png"
      }
    },
    {
      "team": {
        "id": 16,
        "name": "Mexico",
        "code": "MEX",
        "country": "Mexico",
        "founded": 1927,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/16.png"
      },
      "venue": {
        "id": 1069,
        "name": "Estadio Azteca",
        "address": "Calzada de Tlalpan 3665, Coyoacán",
        "city": "D.F.",
        "capacity": 106187,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1069.png"
      }
    },
    {
      "team": {
        "id": 1114,
        "name": "Moldova",
        "code": "MOL",
        "country": "Moldova",
        "founded": 1990,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1114.png"
      },
      "venue": {
        "id": 2615,
        "name": "Stadionul Zimbru",
        "address": "Bulevardul Dacia, nr. 45",
        "city": "Chişinău",
        "capacity": 10500,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/2615.png"
      }
    },
    {
      "team": {
        "id": 5534,
        "name": "Mongolia",
        "code": null,
        "country": "Mongolia",
        "founded": 1959,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/5534.png"
      },
      "venue": {
        "id": 4156,
        "name": "National Sports Stadium Mongolia",
        "address": null,
        "city": "Ulaanbaatar",
        "capacity": 20000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/4156.png"
      }
    },
    {
      "team": {
        "id": 1109,
        "name": "Montenegro",
        "code": "MON",
        "country": "Montenegro",
        "founded": 1931,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1109.png"
      },
      "venue": {
        "id": 1095,
        "name": "Stadion Pod Goricom",
        "address": "ul. Vaka Đurovića bb 2",
        "city": "Podgorica",
        "capacity": 15230,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1095.png"
      }
    },
    {
      "team": {
        "id": 31,
        "name": "Morocco",
        "code": "MOR",
        "country": "Morocco",
        "founded": 1955,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/31.png"
      },
      "venue": {
        "id": 1099,
        "name": "Stade Mohamed V",
        "address": "Rue Ali Abderrazak, Bouskoura, Maarif",
        "city": "Casablanca",
        "capacity": 45891,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1099.png"
      }
    },
    {
      "team": {
        "id": 1556,
        "name": "Myanmar",
        "code": "MYA",
        "country": "Myanmar",
        "founded": 1947,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1556.png"
      },
      "venue": {
        "id": 19697,
        "name": "Thuwunna Stadium",
        "address": "Wai Za Yan Tar Road, Thingangyun",
        "city": "Yangon",
        "capacity": 32000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/19697.png"
      }
    },
    {
      "team": {
        "id": 1493,
        "name": "Namibia",
        "code": "NAM",
        "country": "Namibia",
        "founded": 1990,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1493.png"
      },
      "venue": {
        "id": 1114,
        "name": "Independence Stadium",
        "address": "Olympia",
        "city": "Windhoek",
        "capacity": 25000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1114.png"
      }
    },
    {
      "team": {
        "id": 1545,
        "name": "Nepal",
        "code": "NEP",
        "country": "Nepal",
        "founded": 1951,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1545.png"
      },
      "venue": {
        "id": 3896,
        "name": "Dashrath Rangasala",
        "address": "Kantipath Road, Tripureshwor",
        "city": "Kathmandu",
        "capacity": 25000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/3896.png"
      }
    },
    {
      "team": {
        "id": 1118,
        "name": "Netherlands",
        "code": "NET",
        "country": "Netherlands",
        "founded": 1889,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1118.png"
      },
      "venue": {
        "id": 1117,
        "name": "Johan Cruijff Arena",
        "address": "ArenA Boulevard 1",
        "city": "Amsterdam",
        "capacity": 54990,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1117.png"
      }
    },
    {
      "team": {
        "id": 1716,
        "name": "New Zealand W",
        "code": null,
        "country": "New-Zealand",
        "founded": 1891,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1716.png"
      },
      "venue": {
        "id": null,
        "name": null,
        "address": null,
        "city": null,
        "capacity": null,
        "surface": null,
        "image": null
      }
    },
    {
      "team": {
        "id": 5164,
        "name": "Nicaragua",
        "code": null,
        "country": "Nicaragua",
        "founded": 1931,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/5164.png"
      },
      "venue": {
        "id": 3501,
        "name": "Estadio Nacional de Fútbol (UNAN)",
        "address": "Pista de La Unan",
        "city": "Managua",
        "capacity": 15000,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/3501.png"
      }
    },
    {
      "team": {
        "id": 19,
        "name": "Nigeria",
        "code": "NIG",
        "country": "Nigeria",
        "founded": 1945,
        "national": true,
        "logo": "https://media-3.api-sports.io/football/teams/19.png"
      },
      "venue": {
        "id": 1168,
        "name": "Abuja National Stadium",
        "address": "Independence Avenue, Kukwaba",
        "city": "Abuja",
        "capacity": 60491,
        "surface": "grass",
        "image": "https://media-2.api-sports.io/football/venues/1168.png"
      }
    },
    {
      "team": {
        "id": 771,
        "name": "Northern Ireland",
        "code": null,
        "country": "Northern-Ireland",
        "founded": 1880,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/771.png"
      },
      "venue": {
        "id": 1971,
        "name": "Windsor Park",
        "address": "Donegall Avenue",
        "city": "Belfast",
        "capacity": 18614,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1971.png"
      }
    },
    {
      "team": {
        "id": 1090,
        "name": "Norway",
        "code": "NOR",
        "country": "Norway",
        "founded": 1902,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1090.png"
      },
      "venue": {
        "id": 11603,
        "name": "Ullevaal Stadion",
        "address": "Sognsveien 75",
        "city": "Oslo",
        "capacity": 27182,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/11603.png"
      }
    },
    {
      "team": {
        "id": 774,
        "name": "Romania",
        "code": "ROM",
        "country": "Romania",
        "founded": 1909,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/774.png"
      },
      "venue": {
        "id": 1326,
        "name": "Arena Naţională",
        "address": "Bulevardul Basarabia 37-39",
        "city": "Bucureşti",
        "capacity": 55611,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1326.png"
      }
    },
    {
      "team": {
        "id": 5535,
        "name": "Pakistan",
        "code": "PAK",
        "country": "Pakistan",
        "founded": 1948,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/5535.png"
      },
      "venue": {
        "id": 4157,
        "name": "Punjab Stadium",
        "address": "Ferozpur Road",
        "city": "Lahore",
        "capacity": 8000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/4157.png"
      }
    },
    {
      "team": {
        "id": 1562,
        "name": "Palestine",
        "code": "PAL",
        "country": "Palestine",
        "founded": 1928,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1562.png"
      },
      "venue": {
        "id": 1206,
        "name": "Faisal Al-Husseini International Stadium",
        "address": null,
        "city": "Al-Ram",
        "capacity": 12500,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/1206.png"
      }
    },
    {
      "team": {
        "id": 11,
        "name": "Panama",
        "code": "PAN",
        "country": "Panama",
        "founded": 1937,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/11.png"
      },
      "venue": {
        "id": 1207,
        "name": "Estadio Rommel Fernández Gutiérrez",
        "address": "Avenida José Agustin Arango",
        "city": "Ciudad de Panamá",
        "capacity": 45000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1207.png"
      }
    },
    {
      "team": {
        "id": 2380,
        "name": "Paraguay",
        "code": "PAR",
        "country": "Paraguay",
        "founded": 1906,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/2380.png"
      },
      "venue": {
        "id": 11622,
        "name": "Estadio Defensores del Chaco",
        "address": "Avenida Martinez y Juan Diaz De Solis, Barrio Sajonia",
        "city": "Asunción",
        "capacity": 42354,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/11622.png"
      }
    },
    {
      "team": {
        "id": 30,
        "name": "Peru",
        "code": "PER",
        "country": "Peru",
        "founded": 1922,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/30.png"
      },
      "venue": {
        "id": 1228,
        "name": "Estadio Nacional de Lima",
        "address": "Paseo de la Republica",
        "city": "Lima",
        "capacity": 45574,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1228.png"
      }
    },
    {
      "team": {
        "id": 1555,
        "name": "Philippines",
        "code": "PHI",
        "country": "Philippines",
        "founded": 1907,
        "national": true,
        "logo": "https://media-1.api-sports.io/football/teams/1555.png"
      },
      "venue": {
        "id": 1244,
        "name": "Rizal Memorial Stadium",
        "address": "Pablo Ocampo Street (ex. Vito Cruz Street), Malate",
        "city": "Manila",
        "capacity": 30000,
        "surface": "grass",
        "image": "https://media-1.api-sports.io/football/venues/1244.png"
      }
    },
    {
      "team": {
        "id": 24,
        "name": "Poland",
        "code": "POL",
        "country": "Poland",
        "founded": 1919,
        "national": true,
        "logo": "https://media-2.api-sports.io/football/teams/24.png"
      },
      "venue": {
        "id": 1245,
        "name": "Stadion Narodowy",
        "address": "Aleja Księcia J. Poniatowskiego 1",
        "city": "Warszawa",
        "capacity": 58145,
        "surface": "grass",
        "image": "https://media-1.api-sports.io/football/venues/1245.png"
      }
    },
    {
      "team": {
        "id": 27,
        "name": "Portugal",
        "code": "POR",
        "country": "Portugal",
        "founded": 1914,
        "national": true,
        "logo": "https://media-3.api-sports.io/football/teams/27.png"
      },
      "venue": {
        "id": 1262,
        "name": "Estádio Nacional",
        "address": null,
        "city": "Jamor, Oeiras",
        "capacity": 38000,
        "surface": "grass",
        "image": "https://media-2.api-sports.io/football/venues/1262.png"
      }
    },
    {
      "team": {
        "id": 1569,
        "name": "Qatar",
        "code": "QAT",
        "country": "Qatar",
        "founded": 1960,
        "national": true,
        "logo": "https://media-1.api-sports.io/football/teams/1569.png"
      },
      "venue": {
        "id": 19746,
        "name": "Khalifa International Stadium",
        "address": "Al Waab Street",
        "city": "Ar-Rayyan",
        "capacity": 45857,
        "surface": "grass",
        "image": "https://media-3.api-sports.io/football/venues/19746.png"
      }
    },
    {
      "team": {
        "id": 774,
        "name": "Romania",
        "code": "ROM",
        "country": "Romania",
        "founded": 1909,
        "national": true,
        "logo": "https://media-1.api-sports.io/football/teams/774.png"
      },
      "venue": {
        "id": 1326,
        "name": "Arena Naţională",
        "address": "Bulevardul Basarabia 37-39",
        "city": "Bucureşti",
        "capacity": 55611,
        "surface": "grass",
        "image": "https://media-1.api-sports.io/football/venues/1326.png"
      }
    },
    {
      "team": {
        "id": 4,
        "name": "Russia",
        "code": "RUS",
        "country": "Russia",
        "founded": 1912,
        "national": true,
        "logo": "https://media-2.api-sports.io/football/teams/4.png"
      },
      "venue": {
        "id": 1327,
        "name": "RZD Arena",
        "address": "ul. Bol&apos;shaya Cherkizovskaya 125",
        "city": "Moskva",
        "capacity": 28800,
        "surface": "grass",
        "image": "https://media-1.api-sports.io/football/venues/1327.png"
      }
    },
    {
      "team": {
        "id": 1514,
        "name": "Rwanda",
        "code": "RWA",
        "country": "Rwanda",
        "founded": 1972,
        "national": true,
        "logo": "https://media-1.api-sports.io/football/teams/1514.png"
      },
      "venue": {
        "id": 1357,
        "name": "Stade Amahoro",
        "address": "Gasabo",
        "city": "Kigali",
        "capacity": 30000,
        "surface": "grass",
        "image": "https://media-3.api-sports.io/football/venues/1357.png"
      }
    },
    {
      "team": {
        "id": 1115,
        "name": "San Marino",
        "code": null,
        "country": "San-Marino",
        "founded": 1931,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1115.png"
      },
      "venue": {
        "id": 2616,
        "name": "Stadio Olimpico di Serravalle",
        "address": "Via Rancaglia",
        "city": "Serravalle",
        "capacity": 5115,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/2616.png"
      }
    },
    {
      "team": {
        "id": 23,
        "name": "Saudi Arabia",
        "code": "SAU",
        "country": "Saudi-Arabia",
        "founded": 1956,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/23.png"
      },
      "venue": {
        "id": 1361,
        "name": "King Fahd International Stadium",
        "address": "Al-Amir Bandar Ibn Abdul Aziz Street",
        "city": "Riyadh",
        "capacity": 68752,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1361.png"
      }
    },
    {
      "team": {
        "id": 1108,
        "name": "Scotland",
        "code": "SCO",
        "country": "Scotland",
        "founded": 1873,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1108.png"
      },
      "venue": {
        "id": 2617,
        "name": "Hampden Park",
        "address": "Letherby Drive",
        "city": "Glasgow",
        "capacity": 52500,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/2617.png"
      }
    },
    {
      "team": {
        "id": 13,
        "name": "Senegal",
        "code": "SEN",
        "country": "Senegal",
        "founded": 1960,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/13.png"
      },
      "venue": {
        "id": 1405,
        "name": "Stade Léopold Sédar Senghor",
        "address": "Route de l’Aéroport de Yoff",
        "city": "Dakar",
        "capacity": 80000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1405.png"
      }
    },
    {
      "team": {
        "id": 14,
        "name": "Serbia",
        "code": "SER",
        "country": "Serbia",
        "founded": 1919,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/14.png"
      },
      "venue": {
        "id": 1406,
        "name": "Stadion Rajko Mitić",
        "address": "Ljutice Bogdana 1a",
        "city": "Beograd",
        "capacity": 51862,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1406.png"
      }
    },
    {
      "team": {
        "id": 1546,
        "name": "Singapore",
        "code": "SIN",
        "country": "Singapore",
        "founded": 1892,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1546.png"
      },
      "venue": {
        "id": 3897,
        "name": "The National Stadium",
        "address": "1 Stadium Drive, Kallang",
        "city": "Singapore",
        "capacity": 55000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/3897.png"
      }
    },
    {
      "team": {
        "id": 773,
        "name": "Slovakia",
        "code": "SLO",
        "country": "Slovakia",
        "founded": 1993,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/773.png"
      },
      "venue": {
        "id": 11602,
        "name": "CITY ARENA – Štadión Antona Malatinského",
        "address": "ul. Športová 1",
        "city": "Trnava",
        "capacity": 19200,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/11602.png"
      }
    },
    {
      "team": {
        "id": 1091,
        "name": "Slovenia",
        "code": "SLO",
        "country": "Slovenia",
        "founded": 1920,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1091.png"
      },
      "venue": {
        "id": 1442,
        "name": "Stadion Stožice",
        "address": null,
        "city": "Ljubljana",
        "capacity": 16038,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1442.png"
      }
    },
    {
      "team": {
        "id": 8050,
        "name": "Somalia",
        "code": "SOM",
        "country": "Somalia",
        "founded": 1951,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/8050.png"
      },
      "venue": {
        "id": 5734,
        "name": "Muqdisho Stadium",
        "address": "Jidka Janaral Daud",
        "city": "Mogadishu",
        "capacity": 35000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/5734.png"
      }
    },
    {
      "team": {
        "id": 1531,
        "name": "South Africa",
        "code": "SOU",
        "country": "South-Africa",
        "founded": 1991,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1531.png"
      },
      "venue": {
        "id": 1443,
        "name": "FNB Stadium (Soccer City)",
        "address": "Nasrec Road",
        "city": "Johannesburg, GA",
        "capacity": 94736,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1443.png"
      }
    },
    {
      "team": {
        "id": 17,
        "name": "South Korea",
        "code": "SOU",
        "country": "South-Korea",
        "founded": 1933,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/17.png"
      },
      "venue": {
        "id": 1002,
        "name": "Seoul World Cup Stadium",
        "address": "515 Seongsan-dong, Mapo-gu, Sangam",
        "city": "Seoul",
        "capacity": 68476,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1002.png"
      }
    },
    {
      "team": {
        "id": 9,
        "name": "Spain",
        "code": "SPA",
        "country": "Spain",
        "founded": 1913,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/9.png"
      },
      "venue": {
        "id": 1456,
        "name": "Estadio Santiago Bernabéu",
        "address": "Avenida de Concha Espina 1, Chamartín",
        "city": "Madrid",
        "capacity": 85454,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1456.png"
      }
    },
    {
      "team": {
        "id": 1496,
        "name": "South Sudan",
        "code": "SSU",
        "country": "Sudan",
        "founded": 2011,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1496.png"
      },
      "venue": {
        "id": 19756,
        "name": "Juba Stadium",
        "address": null,
        "city": "Juba",
        "capacity": 12000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/19756.png"
      }
    },
    {
      "team": {
        "id": 8171,
        "name": "Suriname",
        "code": null,
        "country": "Surinam",
        "founded": null,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/8171.png"
      },
      "venue": {
        "id": null,
        "name": null,
        "address": null,
        "city": null,
        "capacity": null,
        "surface": null,
        "image": null
      }
    },
    {
      "team": {
        "id": 5,
        "name": "Sweden",
        "code": "SWE",
        "country": "Sweden",
        "founded": 1904,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/5.png"
      },
      "venue": {
        "id": 1501,
        "name": "Friends Arena",
        "address": "Råsta Strandväg 1",
        "city": "Solna",
        "capacity": 54329,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1501.png"
      }
    },
    {
      "team": {
        "id": 15,
        "name": "Switzerland",
        "code": "SWI",
        "country": "Switzerland",
        "founded": 1895,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/15.png"
      },
      "venue": {
        "id": 1530,
        "name": "St. Jakob-Park",
        "address": "Sankt Jakob-Strasse 395",
        "city": "Basel",
        "capacity": 38512,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1530.png"
      }
    },
    {
      "team": {
        "id": 1565,
        "name": "Syria",
        "code": "SYR",
        "country": "Syria",
        "founded": 1936,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1565.png"
      },
      "venue": {
        "id": 1549,
        "name": "Aleppo International Stadium",
        "address": null,
        "city": "Aleppo",
        "capacity": 61000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1549.png"
      }
    },
    {
      "team": {
        "id": 1536,
        "name": "Tajikistan",
        "code": null,
        "country": "Tajikistan",
        "founded": 1936,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1536.png"
      },
      "venue": {
        "id": 3898,
        "name": "Respublikanskiy Stadion im. M.V. Frunze",
        "address": "Ismoil Somoni Ave.",
        "city": "Dushanbe",
        "capacity": 21400,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/3898.png"
      }
    },
    {
      "team": {
        "id": 1489,
        "name": "Tanzania",
        "code": "TAN",
        "country": "Tanzania",
        "founded": 1930,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1489.png"
      },
      "venue": {
        "id": 1550,
        "name": "Benjamin Mkapa National Stadium",
        "address": "Taifa Road",
        "city": "Dar-es-Salaam",
        "capacity": 60000,
        "surface": "artificial turf",
        "image": "https://media-4.api-sports.io/football/venues/1550.png"
      }
    },
    {
      "team": {
        "id": 1564,
        "name": "Thailand",
        "code": "THA",
        "country": "Thailand",
        "founded": 1916,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1564.png"
      },
      "venue": {
        "id": 1551,
        "name": "Rajamangala National Stadium",
        "address": "24 Ramkhamhaeng Street, Hua Mak, Bang Kapi",
        "city": "Bangkok",
        "capacity": 55000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1551.png"
      }
    },
    {
      "team": {
        "id": 5168,
        "name": "Trinidad and Tobago",
        "code": "TRI",
        "country": "Trinidad-And-Tobago",
        "founded": 1908,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/5168.png"
      },
      "venue": {
        "id": 3905,
        "name": "Hasely Crawford Stadium",
        "address": "Wrightson Road, Mucurapo",
        "city": "Port of Spain",
        "capacity": 27000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/3905.png"
      }
    },
    {
      "team": {
        "id": 28,
        "name": "Tunisia",
        "code": "TUN",
        "country": "Tunisia",
        "founded": 1957,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/28.png"
      },
      "venue": {
        "id": 19755,
        "name": "Stade Olympique Hammadi Agrebi",
        "address": "Cité Olympique du 7 novembre",
        "city": "Radès",
        "capacity": 65000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/19755.png"
      }
    },
    {
      "team": {
        "id": 777,
        "name": "Turkey",
        "code": "TUR",
        "country": "Turkey",
        "founded": 1923,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/777.png"
      },
      "venue": {
        "id": 1968,
        "name": "Atatürk Olimpiyat Stadı",
        "address": "Atatürk Olimpiyat Stadı Otoparkı, İkitelli",
        "city": "İstanbul",
        "capacity": 76092,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1968.png"
      }
    },
    {
      "team": {
        "id": 1539,
        "name": "Turkmenistan",
        "code": "TUR",
        "country": "Turkmenistan",
        "founded": 1992,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1539.png"
      },
      "venue": {
        "id": 1591,
        "name": "Saparmyrat Türkmenbaşy Adyndaky Olimpiýa Stadiony",
        "address": null,
        "city": "Ashgabat",
        "capacity": 45000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1591.png"
      }
    },
    {
      "team": {
        "id": 1519,
        "name": "Uganda",
        "code": "UGA",
        "country": "Uganda",
        "founded": 1924,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1519.png"
      },
      "venue": {
        "id": 1592,
        "name": "Mandela National Stadium",
        "address": "Jinja Road",
        "city": "Kampala",
        "capacity": 45202,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1592.png"
      }
    },
    {
      "team": {
        "id": 772,
        "name": "Ukraine",
        "code": "UKR",
        "country": "Ukraine",
        "founded": 1991,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/772.png"
      },
      "venue": {
        "id": 20114,
        "name": "NSK Olimpiiskyi",
        "address": "vul. Velyka Vasylkivska 55",
        "city": "Kiev",
        "capacity": 70050,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/20114.png"
      }
    },
    {
      "team": {
        "id": 1563,
        "name": "United Arab Emirates",
        "code": "UAE",
        "country": "United-Arab-Emirates",
        "founded": 1971,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1563.png"
      },
      "venue": {
        "id": 1598,
        "name": "Sheikh Zayed Sports City",
        "address": "Airport Road",
        "city": "Abu Dhabi",
        "capacity": 49500,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1598.png"
      }
    },
    {
      "team": {
        "id": 7,
        "name": "Uruguay",
        "code": "URU",
        "country": "Uruguay",
        "founded": 1900,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/7.png"
      },
      "venue": {
        "id": 1624,
        "name": "Estadio Centenario",
        "address": "Avenida Dr. Alfredo Navarro y Dr. Américo Ricaldoni, Parque Batlle",
        "city": "Montevideo",
        "capacity": 60235,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1624.png"
      }
    },
    {
      "team": {
        "id": 1718,
        "name": "USA W",
        "code": null,
        "country": "USA",
        "founded": 1913,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1718.png"
      },
      "venue": {
        "id": null,
        "name": null,
        "address": null,
        "city": null,
        "capacity": null,
        "surface": null,
        "image": null
      }
    },
    {
      "team": {
        "id": 1568,
        "name": "Uzbekistan",
        "code": "UZB",
        "country": "Uzbekistan",
        "founded": 1946,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1568.png"
      },
      "venue": {
        "id": 1648,
        "name": "Milliy Stadion",
        "address": "Bunyodkor Avenue",
        "city": "Tashkent",
        "capacity": 34000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1648.png"
      }
    },
    {
      "team": {
        "id": 2379,
        "name": "Venezuela",
        "code": "VEN",
        "country": "Venezuela",
        "founded": 1926,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/2379.png"
      },
      "venue": {
        "id": 1649,
        "name": "Estadio Polideportivo de Pueblo Nuevo",
        "address": "Avenida España",
        "city": "San Cristóbal",
        "capacity": 40000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1649.png"
      }
    },
    {
      "team": {
        "id": 1542,
        "name": "Vietnam",
        "code": "VIE",
        "country": "Vietnam",
        "founded": 1962,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1542.png"
      },
      "venue": {
        "id": 1666,
        "name": "Sân vận động quốc gia Mỹ Đình (My Dinh National Stadium)",
        "address": "Từ Liêm",
        "city": "Hanoi",
        "capacity": 40192,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1666.png"
      }
    },
    {
      "team": {
        "id": 767,
        "name": "Wales",
        "code": "WAL",
        "country": "Wales",
        "founded": 1876,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/767.png"
      },
      "venue": {
        "id": 1969,
        "name": "Principality Stadium",
        "address": "Westgate Street",
        "city": "Caerdydd",
        "capacity": 74500,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1969.png"
      }
    },
    {
      "team": {
        "id": 1507,
        "name": "Zambia",
        "code": "ZAM",
        "country": "Zambia",
        "founded": 1929,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1507.png"
      },
      "venue": {
        "id": 1688,
        "name": "Konkola Stadium",
        "address": null,
        "city": "Chililabombwe",
        "capacity": 15000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1688.png"
      }
    },
    {
      "team": {
        "id": 1522,
        "name": "Zimbabwe",
        "code": "ZIM",
        "country": "Zimbabwe",
        "founded": 1965,
        "national": true,
        "logo": "https://media-4.api-sports.io/football/teams/1522.png"
      },
      "venue": {
        "id": 1689,
        "name": "National Sports Stadium",
        "address": "Golden Quarry Road",
        "city": "Harare",
        "capacity": 60000,
        "surface": "grass",
        "image": "https://media-4.api-sports.io/football/venues/1689.png"
      }
    }
  ]
}
"""
   

    do{
        
        let data: TeamDetailsResponse = try js.toObject()
        
//        print("data len => \(data.response.count)")
        
        return data.response
    }
    catch{
        
        print("error is => \(error)")
        return []
    }
    
    
}
