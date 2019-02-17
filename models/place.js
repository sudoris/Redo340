const mongoose = require("mongoose");
const Schema = mongoose.Schema;

// create geolocation Schema
const GeoSchema = new Schema({
	type: {
		type: String,
		default: "Point"
	},
	coordinates: {
		type: [Number],
		index: "2dsphere"
	}
});

// create place Schema and model
const PlaceSchema = new Schema({
	name: {
		type: String,
		required: [true, "Name field is required."]
	},
	rank: {
		type: String
	},
	available: {
		type: Boolean,
		default: false
	},
	// add geo location
	geometry: GeoSchema


});

const Place = mongoose.model("place", PlaceSchema);
module.exports = Place;	