"use strict";

/**
 * A set of functions called "actions" for `get-filter-packages`
 */

module.exports = {
  // exampleAction: async (ctx, next) => {
  //   try {
  //     ctx.body = 'ok';
  //   } catch (err) {
  //     ctx.body = err;
  //   }
  // }

  async getFilterPackages(ctx, _) {
    try {
      ctx.body = await strapi
        .service("api::get-filter-packages.get-filter-packages")
        .getFilterPackages(ctx.header.token);
    } catch (error) {
      console.error("Error:", error);
      ctx.badRequest("get-filter-packages Cnt Error:", { moreDetails: error });
    }
  },
};
