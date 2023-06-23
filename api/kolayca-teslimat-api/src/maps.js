const axios = require("axios");
const config = require("./config");

class RouteCalculator {
  constructor() {
    this.googleApiUrl = "https://routes.googleapis.com/";
    this.headers = {
      "Content-Type": "application/json",
      "X-Goog-Api-Key": config.googleMapsApiKey,
    };

    this.computeRouteMatrix = this.computeRouteMatrix.bind(this);
    this.computeRoute = this.computeRoute.bind(this);
  }

  async computeRouteMatrix(origin, destinations) {
    try {
      this.headers["X-Goog-FieldMask"] =
        "originIndex,destinationIndex,duration,distanceMeters,status,condition";

      return (
        await axios.post(
          this.googleApiUrl + "distanceMatrix/v2:computeRouteMatrix",
          { origins: [origin], destinations: destinations, travelMode: "WALK" },
          {
            headers: this.headers,
          }
        )
      ).data;
    } catch (error) {
      console.error("Catch Error:", error);
      console.log("Data:", error.response.data);
    }
  }

  async computeRoute(origin, destination) {
    this.headers["X-Goog-FieldMask"] =
      "routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline";

    return (
      await axios.post(
        this.googleApiUrl + "directions/v2:computeRoutes",
        {
          origin: origin,
          destination: destination,
          travelMode: "WALK",
          computeAlternativeRoutes: false,
          routeModifiers: { avoidTolls: false, avoidHighways: false },
          languageCode: "en-US",
          units: "IMPERIAL",
        },
        { headers: this.headers }
      )
    ).data.routes[0];
  }
}

module.exports = new RouteCalculator();
