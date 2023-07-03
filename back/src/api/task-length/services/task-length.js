'use strict';

/**
 * task-length service.
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::task-length.task-length');
