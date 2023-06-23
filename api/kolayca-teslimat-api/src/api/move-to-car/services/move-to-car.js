"use strict";

/**
 * move-to-car service
 */

module.exports = () => ({
  moveToCar: async (token, packageId) => {
    try {
      const user = (
        await strapi.entityService.findMany("api::regular-user.regular-user", {
          filters: { token: { $eq: token } },
        })
      )[0];

      if (user === undefined) {
        return { message: "You should be authorized to access this endpoint" };
      }

      const packages = await strapi.db.query("api::package.package").findMany({
        where: {
          $and: [
            {
              $or: [
                { responsibleUserId: { $eq: user.id } },
                { responsibleUserId: { $null: true } },
              ],
            },
            { id: { $eq: packageId } },
          ],
        },
        populate: true,
      });

      if (packages.length === 0) {
        return { message: "Package not found" };
      }

      let chosenPackage = packages[0];

      if (chosenPackage.status !== "Bekleniyor") {
        return { message: "Package not available for delivery" };
      }

      //chosenPackage.status = "Araçta";
      //chosenPackage.responsibleUserId = user.id;

      const updatedPacked = await strapi.entityService.update(
        "api::package.package",
        chosenPackage.id,
        {
          data: { status: "Araçta", responsibleUserId: user.id },
          populate: "*",
        }
      );

      return { package: updatedPacked };
    } catch (error) {
      console.error("move-to-car service:", error);
    }
  },
});
