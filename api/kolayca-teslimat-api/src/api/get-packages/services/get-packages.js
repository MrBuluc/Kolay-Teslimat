"use strict";

/**
 * get-packages service
 */

module.exports = () => ({
  getPackages: async () => {
    try {
      const packages = await strapi.entityService.findMany(
        "api::package.package",
        { populate: "*" }
      );

      return { packages };
    } catch (error) {
      console.error("getPackages Error:", error);
      return { error };
    }
  },
});
