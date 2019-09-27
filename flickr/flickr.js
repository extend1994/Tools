'use strict'

const url = require('flickr-photo-url');

/*
process.argv[0] is `node` command with its path
process.argv[1] is flickr.js (called script's name)
process.argv[2] would be photo's id which is used to find url on flickr
*/
url('99605377@N04', parseInt(process.argv[2]), url.sizes.large)
.then(console.log)
.catch(console.error)
