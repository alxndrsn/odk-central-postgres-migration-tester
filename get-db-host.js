const log = (...args) => console.error('[get-db-host]', ...args);

log('Loading config...');
const config = require('config').get('default.database');
log('Config loaded.');

console.log(config.host);