"use strict";

/**
 * A set of functions called "actions" for `package-complete`
 */

module.exports = {
  // exampleAction: async (ctx, next) => {
  //   try {
  //     ctx.body = 'ok';
  //   } catch (err) {
  //     ctx.body = err;
  //   }
  // }

  packageComplete: async (ctx, _) => {
    try {
      const request = ctx.request;
      if (!request.files || Object.keys(request.files).length === 0) {
        ctx.body = { message: "No files were uploaded" };
      } else {
        ctx.body = await strapi
          .service("api::package-complete.package-complete")
          .packageComplete(
            ctx.header.token,
            request.query.packageId,
            request.files.photo
          );
      }
    } catch (error) {
      console.error(error);
      ctx.badRequest("packageComplete Cnt:", { error });
    }
  },
};
