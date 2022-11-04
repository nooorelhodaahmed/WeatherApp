

import Foundation

struct CitiesModel : Codable {
	let id : Int?
	let name : String?
	let region : String?
	let country : String?
	let lat : Double?
	let lon : Double?
	let url : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case region = "region"
		case country = "country"
		case lat = "lat"
		case lon = "lon"
		case url = "url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		region = try values.decodeIfPresent(String.self, forKey: .region)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		lat = try values.decodeIfPresent(Double.self, forKey: .lat)
		lon = try values.decodeIfPresent(Double.self, forKey: .lon)
		url = try values.decodeIfPresent(String.self, forKey: .url)
	}

}
