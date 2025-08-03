//
//  RankingResponse.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let rankingResponse = try? JSONDecoder().decode(RankingResponse.self, from: jsonData)

import Foundation

// MARK: - RankingResponse
struct RankingResponse: Codable, Sendable {
    let status: Bool
    let data: [RankingData]

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}

// MARK: - Datum
public struct RankingData: Codable, Sendable {
    public let id: Int
    public let points: String
    public let position: Int
    public let teamID: Int
    public let teamName: String
    public let teamLogo: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case points = "points"
        case position = "position"
        case teamID = "team_id"
        case teamName = "team_name"
        case teamLogo = "team_logo"
    }
}

func getDummyRankingData()-> [RankingData]{
    let st = """
{
    "status": true,
    "data": [
        {
            "id": 1,
            "points": "1843.73",
            "position": 1,
            "team_id": 10,
            "team_name": "Argentina",
            "team_logo": "https://flagcdn.com/w320/ar.png"
        },
        {
            "id": 2,
            "points": "1843.54",
            "position": 2,
            "team_id": 85,
            "team_name": "France",
            "team_logo": "https://flagcdn.com/w320/fr.png"
        },
        {
            "id": 3,
            "points": "1828.27",
            "position": 3,
            "team_id": 31,
            "team_name": "Brazil",
            "team_logo": "https://flagcdn.com/w320/br.png"
        },
        {
            "id": 4,
            "points": "1797.39",
            "position": 4,
            "team_id": 74,
            "team_name": "England",
            "team_logo": "http://18.139.62.213/storage/team/pD8eBOmp7XpAdExZPzy2Bg4fk4jV9b5FN1ou0f8Z.png"
        },
        {
            "id": 5,
            "points": "1788.55",
            "position": 5,
            "team_id": 21,
            "team_name": "Belgium",
            "team_logo": "https://flagcdn.com/w320/be.png"
        },
        {
            "id": 6,
            "points": "1742.55",
            "position": 6,
            "team_id": 58,
            "team_name": "Croatia",
            "team_logo": "https://flagcdn.com/w320/hr.png"
        },
        {
            "id": 7,
            "points": "1731.23",
            "position": 7,
            "team_id": 157,
            "team_name": "Netherlands",
            "team_logo": "https://flagcdn.com/w320/nl.png"
        },
        {
            "id": 8,
            "points": "1726.58",
            "position": 8,
            "team_id": 114,
            "team_name": "Italy",
            "team_logo": "https://flagcdn.com/w320/it.png"
        },
        {
            "id": 9,
            "points": "1718.25",
            "position": 9,
            "team_id": 178,
            "team_name": "Portugal",
            "team_logo": "https://flagcdn.com/w320/pt.png"
        },
        {
            "id": 10,
            "points": "1703.45",
            "position": 10,
            "team_id": 209,
            "team_name": "Spain",
            "team_logo": "https://flagcdn.com/w320/es.png"
        },
        {
            "id": 11,
            "points": "1674.48",
            "position": 11,
            "team_id": 236,
            "team_name": "USA",
            "team_logo": "http://18.139.62.213/storage/team/JPJfWKOp83Re8TTRWPhqhlZWQEkm3rjdXpn6hE41.png"
        },
        {
            "id": 12,
            "points": "1665.59",
            "position": 12,
            "team_id": 147,
            "team_name": "Mexico",
            "team_logo": "https://flagcdn.com/w320/mx.png"
        },
        {
            "id": 13,
            "points": "1661.12",
            "position": 13,
            "team_id": 216,
            "team_name": "Switzerland",
            "team_logo": "https://flagcdn.com/w320/ch.png"
        },
        {
            "id": 14,
            "points": "1655.50",
            "position": 14,
            "team_id": 152,
            "team_name": "Morocco",
            "team_logo": "https://flagcdn.com/w320/ma.png"
        },
        {
            "id": 15,
            "points": "1636.32",
            "position": 15,
            "team_id": 90,
            "team_name": "Germany",
            "team_logo": "https://flagcdn.com/w320/de.png"
        },
        {
            "id": 16,
            "points": "1633.13",
            "position": 16,
            "team_id": 234,
            "team_name": "Uruguay",
            "team_logo": "https://flagcdn.com/w320/uy.png"
        },
        {
            "id": 17,
            "points": "1624.91",
            "position": 17,
            "team_id": 49,
            "team_name": "Colombia",
            "team_logo": "https://flagcdn.com/w320/co.png"
        },
        {
            "id": 18,
            "points": "1612.61",
            "position": 18,
            "team_id": 195,
            "team_name": "Senegal",
            "team_logo": "https://flagcdn.com/w320/sn.png"
        },
        {
            "id": 19,
            "points": "1597.37",
            "position": 19,
            "team_id": 65,
            "team_name": "Denmark",
            "team_logo": "https://flagcdn.com/w320/dk.png"
        },
        {
            "id": 20,
            "points": "1595.96",
            "position": 20,
            "team_id": 117,
            "team_name": "Japan",
            "team_logo": "https://flagcdn.com/w320/jp.png"
        },
        {
            "id": 21,
            "points": "1561.20",
            "position": 21,
            "team_id": 175,
            "team_name": "Peru",
            "team_logo": "https://flagcdn.com/w320/pe.png"
        },
        {
            "id": 22,
            "points": "1556.59",
            "position": 22,
            "team_id": 110,
            "team_name": "Iran",
            "team_logo": "https://flagcdn.com/w320/ir.png"
        },
        {
            "id": 23,
            "points": "1547.11",
            "position": 23,
            "team_id": 215,
            "team_name": "Sweden",
            "team_logo": "https://flagcdn.com/w320/se.png"
        },
        {
            "id": 24,
            "points": "1541.25",
            "position": 24,
            "team_id": 232,
            "team_name": "Ukraine",
            "team_logo": "https://flagcdn.com/w320/ua.png"
        },
        {
            "id": 25,
            "points": "1539.03",
            "position": 25,
            "team_id": 196,
            "team_name": "Serbia",
            "team_logo": "https://flagcdn.com/w320/rs.png"
        },
        {
            "id": 26,
            "points": "1536.99",
            "position": 26,
            "team_id": 177,
            "team_name": "Poland",
            "team_logo": "https://flagcdn.com/w320/pl.png"
        },
        {
            "id": 27,
            "points": "1530.45",
            "position": 27,
            "team_id": 13,
            "team_name": "Australia",
            "team_logo": "https://flagcdn.com/w320/au.png"
        },
        {
            "id": 28,
            "points": "1529.30",
            "position": 28,
            "team_id": 121,
            "team_name": "Korea-Republic",
            "team_logo": "-"
        },
        {
            "id": 29,
            "points": "1528.06",
            "position": 29,
            "team_id": 14,
            "team_name": "Austria",
            "team_logo": "https://flagcdn.com/w320/at.png"
        },
        {
            "id": 30,
            "points": "1520.24",
            "position": 30,
            "team_id": 194,
            "team_name": "Scotland",
            "team_logo": "http://18.139.62.213/storage/team/LRVRZ1NXTOkIM1KbFbf89kEF4zyEZQcE8hy91Yl2.png"
        },
        {
            "id": 31,
            "points": "1516.66",
            "position": 31,
            "team_id": 226,
            "team_name": "Tunisia",
            "team_logo": "https://flagcdn.com/w320/tn.png"
        },
        {
            "id": 32,
            "points": "1511.31",
            "position": 32,
            "team_id": 46,
            "team_name": "Chile",
            "team_logo": "https://flagcdn.com/w320/cl.png"
        },
        {
            "id": 33,
            "points": "1511.23",
            "position": 33,
            "team_id": 3,
            "team_name": "Algeria",
            "team_logo": "https://flagcdn.com/w320/dz.png"
        },
        {
            "id": 34,
            "points": "1509.89",
            "position": 34,
            "team_id": 71,
            "team_name": "Egypt",
            "team_logo": "https://flagcdn.com/w320/eg.png"
        },
        {
            "id": 35,
            "points": "1506.04",
            "position": 35,
            "team_id": 241,
            "team_name": "Wales",
            "team_logo": "http://18.139.62.213/storage/team/8nufeZ5BMHoPMIkxQZhkkriNVfqDi6eNsPOFkHTT.png"
        },
        {
            "id": 36,
            "points": "1504.57",
            "position": 36,
            "team_id": 105,
            "team_name": "Hungary",
            "team_logo": "https://flagcdn.com/w320/hu.png"
        },
        {
            "id": 37,
            "points": "1503.69",
            "position": 37,
            "team_id": 64,
            "team_name": "Czechia",
            "team_logo": "https://flagcdn.com/w320/cz.png"
        },
        {
            "id": 38,
            "points": "1495.53",
            "position": 38,
            "team_id": 183,
            "team_name": "Russia",
            "team_logo": "https://flagcdn.com/w320/ru.png"
        },
        {
            "id": 39,
            "points": "1486.48",
            "position": 39,
            "team_id": 163,
            "team_name": "Nigeria",
            "team_logo": "https://flagcdn.com/w320/ng.png"
        },
        {
            "id": 40,
            "points": "1486.47",
            "position": 40,
            "team_id": 70,
            "team_name": "Ecuador",
            "team_logo": "https://flagcdn.com/w320/ec.png"
        },
        {
            "id": 41,
            "points": "1484.47",
            "position": 41,
            "team_id": 227,
            "team_name": "Turkey",
            "team_logo": "https://flagcdn.com/w320/tr.png"
        },
        {
            "id": 42,
            "points": "1470.97",
            "position": 42,
            "team_id": 40,
            "team_name": "Cameroon",
            "team_logo": "https://flagcdn.com/w320/cm.png"
        },
        {
            "id": 43,
            "points": "1458.58",
            "position": 43,
            "team_id": 41,
            "team_name": "Canada",
            "team_logo": "https://flagcdn.com/w320/ca.png"
        },
        {
            "id": 44,
            "points": "1458.47",
            "position": 44,
            "team_id": 168,
            "team_name": "Norway",
            "team_logo": "https://flagcdn.com/w320/no.png"
        },
        {
            "id": 45,
            "points": "1453.94",
            "position": 45,
            "team_id": 172,
            "team_name": "Panama",
            "team_logo": "https://flagcdn.com/w320/pa.png"
        },
        {
            "id": 46,
            "points": "1453.56",
            "position": 46,
            "team_id": 56,
            "team_name": "Costa-Rica",
            "team_logo": "https://flagcdn.com/w320/cr.png"
        },
        {
            "id": 47,
            "points": "1447.05",
            "position": 47,
            "team_id": 201,
            "team_name": "Slovakia",
            "team_logo": "https://flagcdn.com/w320/sk.png"
        },
        {
            "id": 48,
            "points": "1443.98",
            "position": 48,
            "team_id": 182,
            "team_name": "Romania",
            "team_logo": "https://flagcdn.com/w320/ro.png"
        },
        {
            "id": 49,
            "points": "1442.64",
            "position": 49,
            "team_id": 174,
            "team_name": "Paraguay",
            "team_logo": "https://flagcdn.com/w320/py.png"
        },
        {
            "id": 50,
            "points": "1441.06",
            "position": 50,
            "team_id": 93,
            "team_name": "Greece",
            "team_logo": "https://flagcdn.com/w320/gr.png"
        },
        {
            "id": 51,
            "points": "1438.01",
            "position": 51,
            "team_id": 142,
            "team_name": "Mali",
            "team_logo": "https://flagcdn.com/w320/ml.png"
        },
        {
            "id": 52,
            "points": "1433.38",
            "position": 52,
            "team_id": 115,
            "team_name": "Ivory-Coast",
            "team_logo": "https://flagcdn.com/w320/ci.png"
        },
        {
            "id": 53,
            "points": "1426.26",
            "position": 53,
            "team_id": 112,
            "team_name": "Ireland",
            "team_logo": "https://flagcdn.com/w320/ie.png"
        },
        {
            "id": 54,
            "points": "1421.46",
            "position": 54,
            "team_id": 193,
            "team_name": "Saudi-Arabia",
            "team_logo": "https://flagcdn.com/w320/sa.png"
        },
        {
            "id": 55,
            "points": "1419.47",
            "position": 55,
            "team_id": 84,
            "team_name": "Finland",
            "team_logo": "https://flagcdn.com/w320/fi.png"
        },
        {
            "id": 56,
            "points": "1419.18",
            "position": 56,
            "team_id": 37,
            "team_name": "Burkina-Faso",
            "team_logo": "https://flagcdn.com/w320/bf.png"
        },
        {
            "id": 57,
            "points": "1417.23",
            "position": 57,
            "team_id": 239,
            "team_name": "Venezuela",
            "team_logo": "https://flagcdn.com/w320/ve.png"
        },
        {
            "id": 58,
            "points": "1409.73",
            "position": 58,
            "team_id": 116,
            "team_name": "Jamaica",
            "team_logo": "https://flagcdn.com/w320/jm.png"
        },
        {
            "id": 59,
            "points": "1395.57",
            "position": 59,
            "team_id": 180,
            "team_name": "Qatar",
            "team_logo": "https://flagcdn.com/w320/qa.png"
        },
        {
            "id": 60,
            "points": "1391.13",
            "position": 60,
            "team_id": 91,
            "team_name": "Ghana",
            "team_logo": "https://flagcdn.com/w320/gh.png"
        },
        {
            "id": 61,
            "points": "1391.04",
            "position": 61,
            "team_id": 202,
            "team_name": "Slovenia",
            "team_logo": "https://flagcdn.com/w320/si.png"
        },
        {
            "id": 62,
            "points": "1381.10",
            "position": 62,
            "team_id": 29,
            "team_name": "Bosnia and Herzegovina",
            "team_logo": "https://flagcdn.com/w320/ba.png"
        },
        {
            "id": 63,
            "points": "1368.25",
            "position": 63,
            "team_id": 206,
            "team_name": "South-Africa",
            "team_logo": "https://flagcdn.com/w320/za.png"
        },
        {
            "id": 64,
            "points": "1361.17",
            "position": 64,
            "team_id": 166,
            "team_name": "Northern-Ireland",
            "team_logo": "https://media-1.api-sports.io/flags/gb.svg"
        },
        {
            "id": 65,
            "points": "1357.39",
            "position": 65,
            "team_id": 2,
            "team_name": "Albania",
            "team_logo": "https://flagcdn.com/w320/al.png"
        },
        {
            "id": 66,
            "points": "1354.65",
            "position": 66,
            "team_id": 42,
            "team_name": "Cape-Verde-Islands",
            "team_logo": "-"
        },
        {
            "id": 67,
            "points": "1352.98",
            "position": 67,
            "team_id": 106,
            "team_name": "Iceland",
            "team_logo": "https://flagcdn.com/w320/is.png"
        },
        {
            "id": 68,
            "points": "1350.53",
            "position": 68,
            "team_id": 165,
            "team_name": "North-Macedonia",
            "team_logo": "https://flagcdn.com/w320/mk.png"
        },
        {
            "id": 69,
            "points": "1350.11",
            "position": 69,
            "team_id": 53,
            "team_name": "Congo-DR",
            "team_logo": "https://media-2.api-sports.io/flags/cg.svg"
        },
        {
            "id": 70,
            "points": "1345.21",
            "position": 70,
            "team_id": 111,
            "team_name": "Iraq",
            "team_logo": "https://flagcdn.com/w320/iq.png"
        },
        {
            "id": 71,
            "points": "1343.45",
            "position": 71,
            "team_id": 150,
            "team_name": "Montenegro",
            "team_logo": "https://flagcdn.com/w320/me.png"
        },
        {
            "id": 72,
            "points": "1336.28",
            "position": 72,
            "team_id": 233,
            "team_name": "United-Arab-Emirates",
            "team_logo": "https://flagcdn.com/w320/ae.png"
        },
        {
            "id": 73,
            "points": "1332.45",
            "position": 73,
            "team_id": 169,
            "team_name": "Oman",
            "team_logo": "https://flagcdn.com/w320/om.png"
        },
        {
            "id": 74,
            "points": "1327.58",
            "position": 74,
            "team_id": 237,
            "team_name": "Uzbekistan",
            "team_logo": "https://flagcdn.com/w320/uz.png"
        },
        {
            "id": 75,
            "points": "1325.47",
            "position": 75,
            "team_id": 73,
            "team_name": "El-Salvador",
            "team_logo": "https://flagcdn.com/w320/sv.png"
        },
        {
            "id": 76,
            "points": "1323.81",
            "position": 76,
            "team_id": 113,
            "team_name": "Israel",
            "team_logo": "https://flagcdn.com/w320/il.png"
        },
        {
            "id": 77,
            "points": "1315.48",
            "position": 77,
            "team_id": 35,
            "team_name": "Bulgaria",
            "team_logo": "https://flagcdn.com/w320/bg.png"
        },
        {
            "id": 78,
            "points": "1312.80",
            "position": 78,
            "team_id": 89,
            "team_name": "Georgia",
            "team_logo": "https://flagcdn.com/w320/ge.png"
        },
        {
            "id": 79,
            "points": "1309.23",
            "position": 79,
            "team_id": 103,
            "team_name": "Honduras",
            "team_logo": "https://flagcdn.com/w320/hn.png"
        },
        {
            "id": 80,
            "points": "1304.78",
            "position": 80,
            "team_id": 47,
            "team_name": "China",
            "team_logo": "https://flagcdn.com/w320/cn.png"
        },
        {
            "id": 81,
            "points": "1296.75",
            "position": 81,
            "team_id": 75,
            "team_name": "Equatorial Guinea",
            "team_logo": "https://flagcdn.com/w320/gq.png"
        },
        {
            "id": 82,
            "points": "1296.26",
            "position": 82,
            "team_id": 118,
            "team_name": "Jordan",
            "team_logo": "https://flagcdn.com/w320/jo.png"
        },
        {
            "id": 83,
            "points": "1295.09",
            "position": 83,
            "team_id": 26,
            "team_name": "Bolivia",
            "team_logo": "https://flagcdn.com/w320/bo.png"
        },
        {
            "id": 84,
            "points": "1293.77",
            "position": 84,
            "team_id": 243,
            "team_name": "Zambia",
            "team_logo": "https://flagcdn.com/w320/zm.png"
        },
        {
            "id": 85,
            "points": "1285.25",
            "position": 85,
            "team_id": 87,
            "team_name": "Gabon",
            "team_logo": "https://flagcdn.com/w320/ga.png"
        },
        {
            "id": 86,
            "points": "1282.05",
            "position": 86,
            "team_id": 17,
            "team_name": "Bahrain",
            "team_logo": "https://flagcdn.com/w320/bh.png"
        },
        {
            "id": 87,
            "points": "1272.64",
            "position": 87,
            "team_id": 101,
            "team_name": "Haiti",
            "team_logo": "https://flagcdn.com/w320/ht.png"
        },
        {
            "id": 88,
            "points": "1267.87",
            "position": 88,
            "team_id": 60,
            "team_name": "Curaçao",
            "team_logo": "https://flagcdn.com/w320/cw.png"
        },
        {
            "id": 89,
            "points": "1262.72",
            "position": 89,
            "team_id": 134,
            "team_name": "Luxembourg",
            "team_logo": "https://flagcdn.com/w320/lu.png"
        },
        {
            "id": 90,
            "points": "1252.60",
            "position": 90,
            "team_id": 11,
            "team_name": "Armenia",
            "team_logo": "https://flagcdn.com/w320/am.png"
        },
        {
            "id": 91,
            "points": "1251.83",
            "position": 91,
            "team_id": 76,
            "team_name": "Equatorial-Guinea",
            "team_logo": "https://flagcdn.com/w320/gq.png"
        },
        {
            "id": 92,
            "points": "1250.32",
            "position": 92,
            "team_id": 231,
            "team_name": "Uganda",
            "team_logo": "https://flagcdn.com/w320/ug.png"
        },
        {
            "id": 93,
            "points": "1248.13",
            "position": 93,
            "team_id": 23,
            "team_name": "Benin",
            "team_logo": "https://flagcdn.com/w320/bj.png"
        },
        {
            "id": 94,
            "points": "1241.62",
            "position": 94,
            "team_id": 217,
            "team_name": "Syria",
            "team_logo": "https://flagcdn.com/w320/sy.png"
        },
        {
            "id": 95,
            "points": "1238.23",
            "position": 95,
            "team_id": 240,
            "team_name": "Vietnam",
            "team_logo": "https://flagcdn.com/w320/vn.png"
        },
        {
            "id": 96,
            "points": "1233.02",
            "position": 96,
            "team_id": 171,
            "team_name": "Palestine",
            "team_logo": "https://flagcdn.com/w320/ps.png"
        },
        {
            "id": 97,
            "points": "1224.80",
            "position": 97,
            "team_id": 124,
            "team_name": "Kyrgyz-Republic",
            "team_logo": "-"
        },
        {
            "id": 98,
            "points": "1212.28",
            "position": 98,
            "team_id": 20,
            "team_name": "Belarus",
            "team_logo": "https://flagcdn.com/w320/by.png"
        },
        {
            "id": 99,
            "points": "1208.69",
            "position": 99,
            "team_id": 107,
            "team_name": "India",
            "team_logo": "https://flagcdn.com/w320/in.png"
        },
        {
            "id": 100,
            "points": "1205.77",
            "position": 100,
            "team_id": 128,
            "team_name": "Lebanon",
            "team_logo": "https://flagcdn.com/w320/lb.png"
        },
        {
            "id": 101,
            "points": "1205.18",
            "position": 101,
            "team_id": 145,
            "team_name": "Mauritania",
            "team_logo": "https://flagcdn.com/w320/mr.png"
        },
        {
            "id": 102,
            "points": "1199.74",
            "position": 102,
            "team_id": 225,
            "team_name": "Trinidad-And-Tobago",
            "team_logo": "https://flagcdn.com/w320/tt.png"
        },
        {
            "id": 103,
            "points": "1199.04",
            "position": 103,
            "team_id": 160,
            "team_name": "New-Zealand",
            "team_logo": "https://flagcdn.com/w320/nz.png"
        },
        {
            "id": 104,
            "points": "1198.24",
            "position": 104,
            "team_id": 119,
            "team_name": "Kazakhstan",
            "team_logo": "https://flagcdn.com/w320/kz.png"
        },
        {
            "id": 105,
            "points": "1191.07",
            "position": 105,
            "team_id": 120,
            "team_name": "Kenya",
            "team_logo": "https://flagcdn.com/w320/ke.png"
        },
        {
            "id": 106,
            "points": "1190.63",
            "position": 106,
            "team_id": 51,
            "team_name": "Congo",
            "team_logo": "https://media-2.api-sports.io/flags/cd.svg"
        },
        {
            "id": 107,
            "points": "1186.71",
            "position": 107,
            "team_id": 97,
            "team_name": "Guatemala",
            "team_logo": "https://flagcdn.com/w320/gt.png"
        },
        {
            "id": 108,
            "points": "1186.09",
            "position": 108,
            "team_id": 138,
            "team_name": "Madagascar",
            "team_logo": "https://flagcdn.com/w320/mg.png"
        },
        {
            "id": 109,
            "points": "1179.69",
            "position": 109,
            "team_id": 122,
            "team_name": "Kosovo",
            "team_logo": "https://flagcdn.com/w320/xk.png"
        },
        {
            "id": 110,
            "points": "1179.54",
            "position": 110,
            "team_id": 219,
            "team_name": "Tajikistan",
            "team_logo": "https://flagcdn.com/w320/tj.png"
        },
        {
            "id": 111,
            "points": "1179.30",
            "position": 111,
            "team_id": 78,
            "team_name": "Estonia",
            "team_logo": "https://flagcdn.com/w320/ee.png"
        },
        {
            "id": 112,
            "points": "1178.93",
            "position": 112,
            "team_id": 99,
            "team_name": "Guinea-Bissau",
            "team_logo": "https://flagcdn.com/w320/gw.png"
        },
        {
            "id": 113,
            "points": "1174.37",
            "position": 113,
            "team_id": 221,
            "team_name": "Thailand",
            "team_logo": "https://flagcdn.com/w320/th.png"
        },
        {
            "id": 114,
            "points": "1172.41",
            "position": 114,
            "team_id": 155,
            "team_name": "Namibia",
            "team_logo": "https://flagcdn.com/w320/na.png"
        },
        {
            "id": 115,
            "points": "1169.96",
            "position": 115,
            "team_id": 207,
            "team_name": "South-Korea",
            "team_logo": "https://flagcdn.com/w320/kr.png"
        },
        {
            "id": 116,
            "points": "1169.07",
            "position": 116,
            "team_id": 6,
            "team_name": "Angola",
            "team_logo": "https://flagcdn.com/w320/ao.png"
        },
        {
            "id": 117,
            "points": "1164.25",
            "position": 117,
            "team_id": 153,
            "team_name": "Mozambique",
            "team_logo": "https://flagcdn.com/w320/mz.png"
        },
        {
            "id": 118,
            "points": "1163.73",
            "position": 118,
            "team_id": 61,
            "team_name": "Cyprus",
            "team_logo": "https://flagcdn.com/w320/cy.png"
        },
        {
            "id": 119,
            "points": "1159.82",
            "position": 119,
            "team_id": 88,
            "team_name": "Gambia",
            "team_logo": "https://flagcdn.com/w320/gm.png"
        },
        {
            "id": 120,
            "points": "1156.11",
            "position": 120,
            "team_id": 198,
            "team_name": "Sierra-Leone",
            "team_logo": "https://flagcdn.com/w320/sl.png"
        },
        {
            "id": 121,
            "points": "1140.88",
            "position": 122,
            "team_id": 223,
            "team_name": "Togo",
            "team_logo": "https://flagcdn.com/w320/tg.png"
        },
        {
            "id": 122,
            "points": "1140.65",
            "position": 123,
            "team_id": 139,
            "team_name": "Malawi",
            "team_logo": "https://flagcdn.com/w320/mw.png"
        },
        {
            "id": 123,
            "points": "1138.79",
            "position": 124,
            "team_id": 220,
            "team_name": "Tanzania",
            "team_logo": "https://flagcdn.com/w320/tz.png"
        },
        {
            "id": 124,
            "points": "1138.56",
            "position": 125,
            "team_id": 245,
            "team_name": "Zimbabwe",
            "team_logo": "https://flagcdn.com/w320/zw.png"
        },
        {
            "id": 125,
            "points": "1133.50",
            "position": 126,
            "team_id": 44,
            "team_name": "Central-African-Republic",
            "team_logo": "https://flagcdn.com/w320/cf.png"
        },
        {
            "id": 126,
            "points": "1130.75",
            "position": 127,
            "team_id": 131,
            "team_name": "Libya",
            "team_logo": "https://flagcdn.com/w320/ly.png"
        },
        {
            "id": 127,
            "points": "1129.67",
            "position": 128,
            "team_id": 162,
            "team_name": "Niger",
            "team_logo": "https://flagcdn.com/w320/ne.png"
        },
        {
            "id": 128,
            "points": "1126.30",
            "position": 129,
            "team_id": 82,
            "team_name": "Faroe-Islands",
            "team_logo": "https://flagcdn.com/w320/fo.png"
        },
        {
            "id": 129,
            "points": "1119.99",
            "position": 130,
            "team_id": 50,
            "team_name": "Comoros",
            "team_logo": "https://flagcdn.com/w320/km.png"
        },
        {
            "id": 130,
            "points": "1116.21",
            "position": 131,
            "team_id": 205,
            "team_name": "South Sudan",
            "team_logo": "https://flagcdn.com/w320/ss.png"
        },
        {
            "id": 131,
            "points": "1107.51",
            "position": 132,
            "team_id": 9,
            "team_name": "Antigua-and-Barbuda",
            "team_logo": "http://18.139.62.213/storage/team/8hrCDYnC5jIrlEozBAGc8yaDU0URiuqqlYeHgvTY.png"
        },
        {
            "id": 132,
            "points": "1097.61",
            "position": 133,
            "team_id": 203,
            "team_name": "Solomon-Islands",
            "team_logo": "https://flagcdn.com/w320/sb.png"
        },
        {
            "id": 133,
            "points": "1096.19",
            "position": 134,
            "team_id": 127,
            "team_name": "Latvia",
            "team_logo": "https://flagcdn.com/w320/lv.png"
        },
        {
            "id": 134,
            "points": "1095.66",
            "position": 135,
            "team_id": 176,
            "team_name": "Philippines",
            "team_logo": "https://flagcdn.com/w320/ph.png"
        },
        {
            "id": 135,
            "points": "1091.57",
            "position": 136,
            "team_id": 140,
            "team_name": "Malaysia",
            "team_logo": "https://flagcdn.com/w320/my.png"
        },
        {
            "id": 136,
            "points": "1090.42",
            "position": 137,
            "team_id": 123,
            "team_name": "Kuwait",
            "team_logo": "https://flagcdn.com/w320/kw.png"
        },
        {
            "id": 137,
            "points": "1089.77",
            "position": 138,
            "team_id": 228,
            "team_name": "Turkmenistan",
            "team_logo": "https://flagcdn.com/w320/tm.png"
        },
        {
            "id": 138,
            "points": "1089.46",
            "position": 139,
            "team_id": 184,
            "team_name": "Rwanda",
            "team_logo": "https://flagcdn.com/w320/rw.png"
        },
        {
            "id": 139,
            "points": "1085.06",
            "position": 140,
            "team_id": 38,
            "team_name": "Burundi",
            "team_logo": "https://flagcdn.com/w320/bi.png"
        },
        {
            "id": 140,
            "points": "1076.11",
            "position": 141,
            "team_id": 161,
            "team_name": "Nicaragua",
            "team_logo": "https://flagcdn.com/w320/ni.png"
        },
        {
            "id": 141,
            "points": "1074.47",
            "position": 142,
            "team_id": 80,
            "team_name": "Ethiopia",
            "team_logo": "https://flagcdn.com/w320/et.png"
        },
        {
            "id": 142,
            "points": "1069.97",
            "position": 144,
            "team_id": 133,
            "team_name": "Lithuania",
            "team_logo": "https://flagcdn.com/w320/lt.png"
        },
        {
            "id": 143,
            "points": "1066.81",
            "position": 145,
            "team_id": 185,
            "team_name": "Saint-Kitts-and-Nevis",
            "team_logo": "https://flagcdn.com/w320/kn.png"
        },
        {
            "id": 144,
            "points": "1058.19",
            "position": 146,
            "team_id": 79,
            "team_name": "Eswatini",
            "team_logo": "https://flagcdn.com/w320/sz.png"
        },
        {
            "id": 145,
            "points": "1054.31",
            "position": 147,
            "team_id": 30,
            "team_name": "Botswana",
            "team_logo": "https://flagcdn.com/w320/bw.png"
        },
        {
            "id": 146,
            "points": "1049.94",
            "position": 148,
            "team_id": 130,
            "team_name": "Liberia",
            "team_logo": "https://flagcdn.com/w320/lr.png"
        },
        {
            "id": 147,
            "points": "1049.74",
            "position": 149,
            "team_id": 104,
            "team_name": "Hong-Kong",
            "team_logo": "https://flagcdn.com/w320/hk.png"
        },
        {
            "id": 148,
            "points": "1047.46",
            "position": 150,
            "team_id": 108,
            "team_name": "Indonesia",
            "team_logo": "https://flagcdn.com/w320/id.png"
        },
        {
            "id": 149,
            "points": "1038.68",
            "position": 151,
            "team_id": 129,
            "team_name": "Lesotho",
            "team_logo": "https://flagcdn.com/w320/ls.png"
        },
        {
            "id": 150,
            "points": "1036.74",
            "position": 152,
            "team_id": 68,
            "team_name": "Dominican-Republic",
            "team_logo": "https://flagcdn.com/w320/do.png"
        },
        {
            "id": 151,
            "points": "1028.18",
            "position": 153,
            "team_id": 48,
            "team_name": "Chinese-Taipei",
            "team_logo": "https://media-1.api-sports.io/flags/tw.svg"
        },
        {
            "id": 152,
            "points": "1022.30",
            "position": 154,
            "team_id": 5,
            "team_name": "Andorra",
            "team_logo": "https://flagcdn.com/w320/ad.png"
        },
        {
            "id": 153,
            "points": "1021.85",
            "position": 155,
            "team_id": 141,
            "team_name": "Maldives",
            "team_logo": "https://flagcdn.com/w320/mv.png"
        },
        {
            "id": 154,
            "points": "1020.37",
            "position": 156,
            "team_id": 242,
            "team_name": "Yemen",
            "team_logo": "https://flagcdn.com/w320/ye.png"
        },
        {
            "id": 155,
            "points": "1020.32",
            "position": 157,
            "team_id": 1,
            "team_name": "Afghanistan",
            "team_logo": "http://18.139.62.213/storage/team/OMKEsMWPrA7Imhry0kVwYS5LlizqtQRgTNqtJ8Mm.png"
        },
        {
            "id": 156,
            "points": "1014.78",
            "position": 158,
            "team_id": 199,
            "team_name": "Singapore",
            "team_logo": "https://flagcdn.com/w320/sg.png"
        },
        {
            "id": 157,
            "points": "1003.28",
            "position": 159,
            "team_id": 173,
            "team_name": "Papua-New-Guinea",
            "team_logo": "https://flagcdn.com/w320/pg.png"
        },
        {
            "id": 158,
            "points": "1000.26",
            "position": 160,
            "team_id": 154,
            "team_name": "Myanmar",
            "team_logo": "https://flagcdn.com/w320/mm.png"
        },
        {
            "id": 159,
            "points": "995.58",
            "position": 161,
            "team_id": 159,
            "team_name": "New-Caledonia",
            "team_logo": "https://flagcdn.com/w320/nc.png"
        },
        {
            "id": 160,
            "points": "995.11",
            "position": 162,
            "team_id": 218,
            "team_name": "Tahiti",
            "team_logo": "-"
        },
        {
            "id": 161,
            "points": "993.80",
            "position": 163,
            "team_id": 179,
            "team_name": "Puerto-Rico",
            "team_logo": "https://flagcdn.com/w320/pr.png"
        },
        {
            "id": 162,
            "points": "990.73",
            "position": 164,
            "team_id": 148,
            "team_name": "Moldova",
            "team_logo": "https://flagcdn.com/w320/md.png"
        },
        {
            "id": 163,
            "points": "986.44",
            "position": 165,
            "team_id": 238,
            "team_name": "Vanuatu",
            "team_logo": "https://flagcdn.com/w320/vu.png"
        },
        {
            "id": 164,
            "points": "984.05",
            "position": 166,
            "team_id": 19,
            "team_name": "Barbados",
            "team_logo": "https://flagcdn.com/w320/bb.png"
        },
        {
            "id": 165,
            "points": "983.35",
            "position": 167,
            "team_id": 208,
            "team_name": "South-Sudan",
            "team_logo": "https://flagcdn.com/w320/ss.png"
        },
        {
            "id": 166,
            "points": "981.69",
            "position": 168,
            "team_id": 100,
            "team_name": "Guyana",
            "team_logo": "https://flagcdn.com/w320/gy.png"
        },
        {
            "id": 167,
            "points": "980.48",
            "position": 169,
            "team_id": 83,
            "team_name": "Fiji",
            "team_logo": "https://flagcdn.com/w320/fj.png"
        },
        {
            "id": 168,
            "points": "978.91",
            "position": 170,
            "team_id": 186,
            "team_name": "Saint-Lucia",
            "team_logo": "https://flagcdn.com/w320/lc.png"
        },
        {
            "id": 169,
            "points": "972.86",
            "position": 171,
            "team_id": 143,
            "team_name": "Malta",
            "team_logo": "https://flagcdn.com/w320/mt.png"
        },
        {
            "id": 170,
            "points": "968.29",
            "position": 172,
            "team_id": 59,
            "team_name": "Cuba",
            "team_logo": "https://flagcdn.com/w320/cu.png"
        },
        {
            "id": 171,
            "points": "966.27",
            "position": 173,
            "team_id": 24,
            "team_name": "Bermuda",
            "team_logo": "https://flagcdn.com/w320/bm.png"
        },
        {
            "id": 172,
            "points": "960.77",
            "position": 174,
            "team_id": 94,
            "team_name": "Grenada",
            "team_logo": "https://flagcdn.com/w320/gd.png"
        },
        {
            "id": 173,
            "points": "958.05",
            "position": 175,
            "team_id": 156,
            "team_name": "Nepal",
            "team_logo": "https://flagcdn.com/w320/np.png"
        },
        {
            "id": 174,
            "points": "942.97",
            "position": 176,
            "team_id": 39,
            "team_name": "Cambodia",
            "team_logo": "https://flagcdn.com/w320/kh.png"
        },
        {
            "id": 175,
            "points": "939.96",
            "position": 177,
            "team_id": 22,
            "team_name": "Belize",
            "team_logo": "https://flagcdn.com/w320/bz.png"
        },
        {
            "id": 176,
            "points": "938.28",
            "position": 178,
            "team_id": 188,
            "team_name": "Saint-Vincent-and-the-Grenadin",
            "team_logo": "-"
        },
        {
            "id": 177,
            "points": "938.02",
            "position": 179,
            "team_id": 151,
            "team_name": "Montserrat",
            "team_logo": "https://flagcdn.com/w320/ms.png"
        },
        {
            "id": 178,
            "points": "936.09",
            "position": 180,
            "team_id": 146,
            "team_name": "Mauritius",
            "team_logo": "https://flagcdn.com/w320/mu.png"
        },
        {
            "id": 179,
            "points": "930.22",
            "position": 181,
            "team_id": 45,
            "team_name": "Chad",
            "team_logo": "https://flagcdn.com/w320/td.png"
        },
        {
            "id": 180,
            "points": "913.68",
            "position": 182,
            "team_id": 136,
            "team_name": "Macao",
            "team_logo": "https://media-2.api-sports.io/flags/mo.svg"
        },
        {
            "id": 181,
            "points": "908.71",
            "position": 183,
            "team_id": 149,
            "team_name": "Mongolia",
            "team_logo": "https://flagcdn.com/w320/mn.png"
        },
        {
            "id": 182,
            "points": "904.88",
            "position": 184,
            "team_id": 67,
            "team_name": "Dominica",
            "team_logo": "https://flagcdn.com/w320/dm.png"
        },
        {
            "id": 183,
            "points": "900.65",
            "position": 185,
            "team_id": 25,
            "team_name": "Bhutan",
            "team_logo": "https://flagcdn.com/w320/bt.png"
        },
        {
            "id": 184,
            "points": "900.07",
            "position": 186,
            "team_id": 192,
            "team_name": "São-Tomé-e-Príncipe",
            "team_logo": "-"
        },
        {
            "id": 185,
            "points": "899.58",
            "position": 187,
            "team_id": 126,
            "team_name": "Laos",
            "team_logo": "https://flagcdn.com/w320/la.png"
        },
        {
            "id": 186,
            "points": "899.33",
            "position": 188,
            "team_id": 54,
            "team_name": "Cook-Islands",
            "team_logo": "https://flagcdn.com/w320/ck.png"
        },
        {
            "id": 187,
            "points": "892.44",
            "position": 189,
            "team_id": 18,
            "team_name": "Bangladesh",
            "team_logo": "https://flagcdn.com/w320/bd.png"
        },
        {
            "id": 188,
            "points": "891.12",
            "position": 190,
            "team_id": 34,
            "team_name": "Brunei-Darussalam",
            "team_logo": "-"
        },
        {
            "id": 189,
            "points": "889.20",
            "position": 191,
            "team_id": 66,
            "team_name": "Djibouti",
            "team_logo": "https://flagcdn.com/w320/dj.png"
        },
        {
            "id": 190,
            "points": "860.45",
            "position": 192,
            "team_id": 222,
            "team_name": "Timor-Leste",
            "team_logo": "https://flagcdn.com/w320/tl.png"
        },
        {
            "id": 191,
            "points": "859.83",
            "position": 193,
            "team_id": 43,
            "team_name": "Cayman-Islands",
            "team_logo": "https://flagcdn.com/w320/ky.png"
        },
        {
            "id": 192,
            "points": "856.71",
            "position": 194,
            "team_id": 197,
            "team_name": "Seychelles",
            "team_logo": "https://flagcdn.com/w320/sc.png"
        },
        {
            "id": 193,
            "points": "855.56",
            "position": 195,
            "team_id": 77,
            "team_name": "Eritrea",
            "team_logo": "https://flagcdn.com/w320/er.png"
        },
        {
            "id": 194,
            "points": "854.72",
            "position": 196,
            "team_id": 204,
            "team_name": "Somalia",
            "team_logo": "https://flagcdn.com/w320/so.png"
        },
        {
            "id": 195,
            "points": "852.87",
            "position": 197,
            "team_id": 16,
            "team_name": "Bahamas",
            "team_logo": "https://flagcdn.com/w320/bs.png"
        },
        {
            "id": 196,
            "points": "851.64",
            "position": 198,
            "team_id": 92,
            "team_name": "Gibraltar",
            "team_logo": "https://flagcdn.com/w320/gi.png"
        },
        {
            "id": 197,
            "points": "850.88",
            "position": 199,
            "team_id": 12,
            "team_name": "Aruba",
            "team_logo": "https://flagcdn.com/w320/aw.png"
        },
        {
            "id": 198,
            "points": "848.82",
            "position": 200,
            "team_id": 132,
            "team_name": "Liechtenstein",
            "team_logo": "https://flagcdn.com/w320/li.png"
        },
        {
            "id": 199,
            "points": "847.67",
            "position": 201,
            "team_id": 170,
            "team_name": "Pakistan",
            "team_logo": "https://flagcdn.com/w320/pk.png"
        },
        {
            "id": 200,
            "points": "839.39",
            "position": 202,
            "team_id": 230,
            "team_name": "Turks-and-Caicos-Islands",
            "team_logo": "https://flagcdn.com/w320/tc.png"
        },
        {
            "id": 201,
            "points": "838.33",
            "position": 203,
            "team_id": 96,
            "team_name": "Guam",
            "team_logo": "https://flagcdn.com/w320/gu.png"
        },
        {
            "id": 202,
            "points": "825.25",
            "position": 204,
            "team_id": 210,
            "team_name": "Sri-Lanka",
            "team_logo": "https://flagcdn.com/w320/lk.png"
        },
        {
            "id": 203,
            "points": "816.59",
            "position": 205,
            "team_id": 235,
            "team_name": "US-Virgin-Islands",
            "team_logo": "http://18.139.62.213/storage/team/naTsGkfFEBon58swTiVpqUpt9sQZFk1WYhuiuPuJ.png"
        },
        {
            "id": 204,
            "points": "804.11",
            "position": 206,
            "team_id": 32,
            "team_name": "British-Virgin-Islands",
            "team_logo": "https://flagcdn.com/w320/vg.png"
        },
        {
            "id": 205,
            "points": "785.69",
            "position": 207,
            "team_id": 7,
            "team_name": "Anguilla",
            "team_logo": "https://flagcdn.com/w320/ai.png"
        },
        {
            "id": 206,
            "points": "753.11",
            "position": 208,
            "team_id": 191,
            "team_name": "San-Marino",
            "team_logo": "https://flagcdn.com/w320/sm.png"
        }
    ]
}
"""
    
    do{
        
        let data: RankingResponse? = try?   st.toObject()
        
        
        return data?.data ?? []
    }
    
}
