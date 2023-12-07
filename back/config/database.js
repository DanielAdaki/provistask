module.exports = ({ env }) => ({
  connection: {
    client: 'mysql',
    connection: {
      host: env('DATABASE_HOST', '193.203.167.168'),
      port: env.int('DATABASE_PORT', 3306),
      database: env('DATABASE_NAME', 'server_provitask'),
      user: env('DATABASE_USERNAME', 'root'),
      password: env('DATABASE_PASSWORD', ''),
      ssl: env.bool('DATABASE_SSL', false),
    },
  },
});
