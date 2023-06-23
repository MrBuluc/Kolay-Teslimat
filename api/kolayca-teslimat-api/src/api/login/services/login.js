"use strict";

/**
 * login service
 */

module.exports = () => ({
  login: async (phoneNumber) => {
    try {
      const user = (
        await strapi.entityService.findMany("api::regular-user.regular-user", {
          filters: { phoneNumber: { $eq: phoneNumber } },
        })
      )[0];

      if (user === undefined) {
        return { message: "User not found" };
      }

      return { user };
    } catch (error) {
      return error;
    }
  },
});
