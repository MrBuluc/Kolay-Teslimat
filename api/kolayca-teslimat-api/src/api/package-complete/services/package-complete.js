"use strict";

const { createClient } = require("@supabase/supabase-js");
const fs = require("fs");

/**
 * package-complete service
 */

module.exports = () => ({
  packageComplete: async (token, packageId, photoFile) => {
    try {
      const user = (
        await strapi.entityService.findMany("api::regular-user.regular-user", {
          filters: { token: { $eq: token } },
        })
      )[0];

      if (user === undefined) {
        return { message: "You should be authorized to access this endpoint" };
      }

      const chosenPackage = (
        await strapi.entityService.findMany("api::package.package", {
          filters: {
            $and: [
              { responsibleUserId: { $eq: user.id } },
              { id: { $eq: packageId } },
            ],
          },
          populate: "*",
        })
      )[0];

      if (chosenPackage === undefined) {
        return { message: "Package not found" };
      }

      if (chosenPackage.status !== "Araçta") {
        return { message: "Package not available for complete" };
      }

      const photoFileName = `${new Date().getTime()}-${photoFile.name}`;

      const supabase = createClient(
        process.env.SUPABASE_API_URL,
        process.env.SUPABASE_API_KEY,
        { auth: { persistSession: false } }
      );

      fs.readFile(photoFile.path, async function (err, buffer) {
        if (err) {
          console.error("fs.readFile Error:", err);
          return { error: err.message };
        }
        const { _, error } = await supabase.storage
          .from("packagePhotos")
          .upload(
            `${user.id}/${photoFileName}`,
            Buffer.from(buffer, "binary"),
            {
              upsert: true,
              contentType: photoFile.type,
              cacheControl: "public, max-age=31536000, immutable",
            }
          );
        if (error) {
          return { error: error.message };
        }
      });

      await strapi.entityService.update(
        "api::package.package",
        chosenPackage.id,
        {
          data: { status: "Teslim Edildi", photo: photoFileName },
          populate: "*",
        }
      );

      return { message: "Package Complete Done" };
    } catch (error) {
      console.error("packageComplete service:", error);
    }
  },
});
