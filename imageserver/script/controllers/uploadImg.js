
const fs = require('fs');
const send = require('koa-send')
const Busboy = require('busboy')

function saveImg(ctx){
  return new Promise((resolve,reject) => {
    let imgName = Date.now()+'.jpg';
    // console.log(ctx.req.headers);

    let busboy = new Busboy({headers: ctx.req.headers})
    // 监听文件解析事件
    busboy.on('file', function(fieldname, file, filename, encoding, mimetype) {
      console.log(`File [${fieldname}]: filename: ${filename}`)

      imgName = filename;
      // 文件保存到特定路径
      file.pipe(fs.createWriteStream('./sources/image/'+imgName));//这一句不执行，后面的事件‘像end、finish之类的’都收不到
    })

    // 监听结束事件
    busboy.on('finish', function() {
      console.log('Done parsing form!')
      resolve({imgName:imgName});
    })

    ctx.req.pipe(busboy)
  });
}

var fn_uploadImg = async (ctx, next) => {

  let result = await saveImg(ctx);
  ctx.body = result

}

module.exports = {
    'POST /uploadimage': fn_uploadImg
};