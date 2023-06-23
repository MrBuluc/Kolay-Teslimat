'use strict';

/**
 * regular-user router
 */

const { createCoreRouter } = require('@strapi/strapi').factories;

module.exports = createCoreRouter('api::regular-user.regular-user');
