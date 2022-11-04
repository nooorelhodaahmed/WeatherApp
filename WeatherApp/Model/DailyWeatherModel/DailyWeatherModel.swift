
import Foundation

struct DailyWeatherModel : Codable {
	let location : Location?
	let current : Current?

	enum CodingKeys: String, CodingKey {

		case location = "location"
		case current = "current"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		location = try values.decodeIfPresent(Location.self, forKey: .location)
		current = try values.decodeIfPresent(Current.self, forKey: .current)
	}

}
