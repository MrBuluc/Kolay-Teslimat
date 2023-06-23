"use strict";

/**
 * get-filter-packages service
 */

module.exports = () => ({
  getFilterPackages: async (token) => {
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
            $or: [
              { responsibleUserId: { $eq: user.id } },
              { responsibleUserId: { $null: true } },
            ],
          },
          populate: "*",
        }
      );

      return { packages };
    } catch (error) {
      console.error("api::get-filter-packages.get-filter-packages:", error);
    }
  },
});
