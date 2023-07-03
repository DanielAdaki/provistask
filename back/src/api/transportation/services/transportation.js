'use strict';

/**
 * transportation service.
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::transportation.transportation');
