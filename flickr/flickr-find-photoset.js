'use strict'

const chalk = require('chalk');
const log = console.log;
const findInFiles = require('find-in-files');
const replace = require('replace-in-file');
const Flickr = require('flickr-sdk');
const https = require('https');
const fs = require('fs');
const glob = require('glob');
const downloadDir = 'flickr-download/';
var flickr = new Flickr(process.env.FLICKR_API_KEY); // API key
var oauth = new Flickr.OAuth(
  process.env.FLICKR_API_KEY,
  process.env.FLICKR_API_SECRET
);

function findPhotoInSet(pattern, relativePath, file){
  findInFiles.find(pattern, relativePath, file)
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
}

function findPhotoNameSizes(pattern, relativePath, file) {
  localDownloadDir = downloadDir + '/' + file
  findInFiles.find(pattern, relativePath, file + '.md')
    .then(function(results) {
      var allfiles = [];
      for (var result in results) {
        // result is *.md with relative path
        var photoUrls = results[result];
        var filesId = photoUrls.matches.map(
          matchedID => matchedID.toString().match(/\/[0-9]+_/)[0].match(/[0-9]+/)[0]
        )
        filesId.forEach( id => {
          var filename, downloadUrl;
          if (id.length == 11) {
            flickr.photos.getInfo({
              photo_id: id
            }).then(function(info){
              filename = info.body.photo.title._content.toString();
              flickr.photos.getSizes({
                photo_id: id
              }).then(function(sizeRes){
                // To download photos
                var sizeNum = sizeRes.body.sizes.size.length;
                downloadUrl = sizeRes.body.sizes.size[sizeNum-1].source;
                if (!fs.existsSync(downloadDir)){
                  fs.mkdirSync(downloadDir);
                }
                if (!fs.existsSync(localDownloadDir)){
                  fs.mkdirSync(localDownloadDir);
                }
                log(filename);
                var fileStream = fs.createWriteStream(localDownloadDir + filename + '.jpg');
                https.get(downloadUrl, function(httpsResponse){
                  httpsResponse.pipe(fileStream);
                })
                //log(`photo ${chalk.yellow(file)} is in album ${chalk.green(ress.body.set[0].title)} ${ress.body.set.length}`)
              }).catch(function(err){
                log(chalk.red(id + ' getSizes ' + err))
              })
            }).catch(function(err){
              log(chalk.red(id + ' getInfo ' + err))
            })
          }
        })
      }
  }).catch(function (err){
    log(err);
  })
}

function uploadToNewSpace(path, title){
  var auth = Flickr.OAuth.createPlugin(
    'c359950d5b815b72ac9bab69023d37c2',
    '4c5710fa285d6955',
    '72157701145633902-999e025fbc2e863e',
    '150c155fd784c06e'
  );
  for (let photo of glob.sync(path + '/*.jpg')) {
    photoname = photo.match(/\/[A-Za-z0-9_]+/)[0].match(/[A-Za-z0-9_]+/)[0]
    Flickr.Upload(auth, photo, {
      title: title
    }).then(function(uploadRes){
      log(`photo ${chalk.yellow(title)} upload state ${chalk.green(uploadRes.body.stat)}`)
    }).catch(function (err) {
      log('err', err);
    });
  }
}

// findPhotoInSet('\/[0-9]+_', 'source/_drafts', '.md$')
findPhotoNameSizes('https:\/\/[a-zA-Z.0-9/_]*.jpg', 'source/_drafts', 'Austria-Wien')
uploadToNewSpace(downloadDir, );