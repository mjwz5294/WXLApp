
const fs = require('fs');
const send = require('koa-send')

var fn_getImg = async (ctx, next) => {
    var imageName = ctx.params.imageName;
    // console.log('--------------------------------------------');
    console.log('1-----',imageName);
    var ex = await haveFile(rootDir+'/source/image/'+imageName);
    var imgName = ex ? imageName:'head.jpg';
    console.log('2-----',imgName);
	await send(ctx,imgName,{root:rootDir+'/source/image'});
};

var haveFile = function (filePath) {
    return new Promise(function (resolve, reject) {
        fs.exists(filePath, function(exists) {
			resolve(exists);
		});
    })
};

module.exports = {
    'GET /image/:imageName': fn_getImg
};