'use strict'

const chalk = require('chalk');
const log = console.log;
const findInFiles = require('find-in-files');
const Flickr = require('flickr-sdk');
var flickr = new Flickr(process.env.FLICKR_API_KEY); // API key
var oauth = new Flickr.OAuth(
  process.env.FLICKR_API_KEY,
  process.env.FLICKR_API_SECRET
);

findInFiles.find("\/[0-9]+_", 'source/_drafts', '.md$')
  .then(function(results) {
    var allfiles = [];
    for (var result in results) {
      // result is *.md with relative path
      var res = results[result];
      var files = res.matches.map(matchedID => matchedID.toString().match(/[0-9]+/)[0])
      var sets = new Set(files)
      sets.forEach( file => {
        if (file.length == 11) {
          flickr.photos.getAllContexts({
            photo_id: file
          })
          .then(function(ress){
            log(`photo ${chalk.yellow(file)} is in album ${chalk.green(ress.body.set[0].title)} ${ress.body.set.length}`)
          }).catch(function(err){
            log(chalk.red(file + ' ' + err))
          })
        }
      })
    }
}).catch(function (err){
  log(err);
})
