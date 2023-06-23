const routeCalculator = require("../../../maps");
("use strict");

/**
 * route service
 */

module.exports = () => ({
  route: async (token, latitude, longitude) => {
    try {
      const user = (
        await strapi.entityService.findMany("api::regular-user.regular-user", {
          filters: { token: { $eq: token } },
        })
      )[0];

      if (user === undefined) {
        return { message: "You should be authorized to access this endpoint" };
      }

      const packages = await strapi.entityService.findMany(
        "api::package.package",
        {
          filters: {
            $and: [
              { responsibleUserId: { $eq: user.id } },
              { status: { $eq: "Araçta" } },
            ],
          },
          populate: "*",
        }
      );

      const origin = {
        waypoint: { location: { latLng: { latitude, longitude } } },
        routeModifiers: { avoid_ferries: true },
      };
      const destinations = packages.map((eachPackage) => {
        return {
          waypoint: {
            location: {
              latLng: {
                latitude: eachPackage.position.latitude,
                longitude: eachPackage.position.longitude,
              },
            },
          },
        };
      });

      const routeMatrix = await routeCalculator.computeRouteMatrix(
        origin,
        destinations
      );

      let matrix = [];
      let requests = [];

      routeMatrix.forEach((route) => {
        matrix.push(destinations[route.destinationIndex]);
      });
      requests.push({
        start: {
          latitude: origin.waypoint.location.latLng.latitude,
          longitude: origin.waypoint.location.latLng.longitude,
        },
        end: {
          latitude: matrix[0].waypoint.location.latLng.latitude,
          longitude: matrix[0].waypoint.location.latLng.longitude,
        },
      });
      if (matrix.length < 2) {
        return { points: [] };
      }
      for (let i = 1; i < matrix.length; i++) {
        requests.push({
          start: {
            latitude: matrix[i - 1].waypoint.location.latLng.latitude,
            longitude: matrix[i - 1].waypoint.location.latLng.longitude,
          },
          end: {
            latitude: matrix[i].waypoint.location.latLng.latitude,
            longitude: matrix[i].waypoint.location.latLng.longitude,
          },
        });
      }

      let responses = [];
      for (let i = 0; i < requests.length; i++) {
        responses.push(
          await routeCalculator.computeRoute(
            {
              location: {
                latLng: {
                  latitude: Number(requests[i].start.latitude),
                  longitude: Number(requests[i].start.longitude),
                },
              },
            },
            {
              location: {
                latLng: {
                  latitude: requests[i].end.latitude,
                  longitude: requests[i].end.longitude,
                },
              },
            }
          )
        );
      }

      return { responses };
    } catch (error) {
      console.error("route service:", error);
    }
  },
});
