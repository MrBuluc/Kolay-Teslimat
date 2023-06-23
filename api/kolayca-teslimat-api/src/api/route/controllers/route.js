"use strict";

/**
 * A set of functions called "actions" for `route`
 */

module.exports = {
  // exampleAction: async (ctx, next) => {
  //   try {
  //     ctx.body = 'ok';
  //   } catch (err) {
  //     ctx.body = err;
  //   }
  // }

  route: async (ctx, _) => {
    try {
      const query = ctx.request.query;
      ctx.body = await strapi
        .service("api::route.route")
        .route(ctx.header.token, query.latitude, query.longitude);
    } catch (error) {
      ctx.badRequest("route Cnt:", { moreDetails: error });
    }
  },
};
