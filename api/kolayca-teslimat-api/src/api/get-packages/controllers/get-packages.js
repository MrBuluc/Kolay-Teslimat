"use strict";

/**
 * A set of functions called "actions" for `get-packages`
 */

module.exports = {
  // exampleAction: async (ctx, next) => {
  //   try {
  //     ctx.body = 'ok';
  //   } catch (err) {
  //     ctx.body = err;
  //   }
  // }

  async getPackages(ctx, _) {
    try {
      ctx.body = await strapi
        .service("api::get-packages.get-packages")
        .getPackages();
    } catch (error) {
      console.error("Error:", error);
      ctx.badRequest("get-packages Cnt Error:", { moreDetails: error });
    }
  },
};
