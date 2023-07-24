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
  'duplicate-button': true,
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

  
  // ...
});
