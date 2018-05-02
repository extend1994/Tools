'use strict'

const url = require('flickr-photo-url');

url('99605377@N04', parseInt(process.argv[2]), url.sizes.large)
.then(console.log)
.catch(console.error)
