var fs = require('fs');
fs.readdir('_posts', (err, files) => {
  try {
    let counter = 0;
    files.forEach(file => {
      // Read the contents of  all files under _post
      fs.readFile('_posts/' + file,'utf8',function (err,data){
        if (err) {
          console.log(err);
        } else {
            // Find the line ended with "/" and to replace it with "/]"
            //Something wrong with this line
            let replaced = data.replace(/\/$/g,'\/]');
            console.log(replaced);
            console.log('----------');
          }
        }
        counter++;
      });
    });
  } catch(err) {
    console.log(err);
  }
});
