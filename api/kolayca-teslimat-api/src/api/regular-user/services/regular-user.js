'use strict';

/**
 * regular-user service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::regular-user.regular-user');
