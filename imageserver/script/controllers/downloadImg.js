const fs = require('fs');
const send = require('koa-send')

var haveFile = function (filePath) {
  return new Promise(function (resolve, reject) {
    fs.exists(filePath, function(exists) {
      resolve(exists);
    });
  })
}

var fn_downloadImg = async (ctx, next) => {
  var imageName = ctx.params.imageName;
  var isImgExist = await haveFile(rootDir+'/sources/image/'+imageName);
  var imgName = isImgExist ? imageName:'head.jpg';
  await send(ctx,imgName,{root:rootDir+'/sources/image'});
}

module.exports = {
    'GET /downloadImg/:imageName': fn_downloadImg,
};