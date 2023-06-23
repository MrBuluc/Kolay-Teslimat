'use strict';

/**
 * regular-user controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::regular-user.regular-user');
