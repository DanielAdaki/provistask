// path: ./config/plugins.js

module.exports = ({ env }) => ({
  // ...
  email: {
    config: {
      provider: 'nodemailer',
      providerOptions: {
        host: env('SMTP_HOST', 'smtp.example.com'),
        port: env('SMTP_PORT', 587),
        auth: {
          user: env('SMTP_USERNAME'),
          pass: env('SMTP_PASSWORD'),
        },
        // ... any custom nodemailer options
      }
    },
  },
  'duplicate-button': false,
  slugify: {
    enabled: true,
    config: {
      contentTypes: {
        skills: {
          field: 'slug',
          references: 'name',
        },
      },
    },
  },
  "generate-data": {
    enabled: true,
},
"rest-cache": {
  config: {
    provider: {
      name: "memory",
      options: {
        max: 32767,
        maxAge: 3600,
      },
    },
    strategy: {
      contentTypes: [
        "api::category.category",
        "api::task.task",
        "plugin::users-permissions.user" 
      ],
    },
  },
},

  
  // ...
});
