"use strict";

/**
 * A set of functions called "actions" for `move-to-car`
 */

module.exports = {
  // exampleAction: async (ctx, next) => {
  //   try {
  //     ctx.body = 'ok';
  //   } catch (err) {
  //     ctx.body = err;
  //   }
  // }

  moveToCar: async (ctx, _) => {
    try {
      ctx.body = await strapi
        .service("api::move-to-car.move-to-car")
        .moveToCar(ctx.header.token, ctx.request.query.packageId);
    } catch (error) {
      console.error("Error:", error);
      ctx.badRequest("moveToCar Cnt Error:", { moreDetails: error });
    }
  },
};
