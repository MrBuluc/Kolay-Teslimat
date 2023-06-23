"use strict";

/**
 * A set of functions called "actions" for `login`
 */

module.exports = {
  // exampleAction: async (ctx, next) => {
  //   try {
  //     ctx.body = 'ok';
  //   } catch (err) {
  //     ctx.body = err;
  //   }
  // }

  async login(ctx, next) {
    try {
      const data = await strapi
        .service("api::login.login")
        .login(ctx.request.query.phoneNumber);

      ctx.body = data;
    } catch (error) {
      ctx.badRequest("Login controller Error:", { moreDetails: error });
    }
  },
};
