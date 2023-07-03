'use strict';

/**
 * task-length router.
 */

const { createCoreRouter } = require('@strapi/strapi').factories;

module.exports = createCoreRouter('api::task-length.task-length');
