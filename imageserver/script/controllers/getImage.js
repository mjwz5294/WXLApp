
const fs = require('fs');
const send = require('koa-send')

var fn_getImg = async (ctx, next) => {
    var imageName = ctx.params.imageName;
    console.log('--------------------------------------------');
    console.log(ctx.path);
	await send(ctx,imageName,{root:rootDir+'/source/image'});
};

module.exports = {
    'GET /image/:imageName': fn_getImg
};