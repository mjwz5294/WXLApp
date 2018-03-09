
const fs = require('fs');
const send = require('koa-send')
const Busboy = require('busboy')

function saveImg(req){
  return new Promise((resolve,reject) => {
    let busboy = new Busboy({headers: req.headers})
    // 监听文件解析事件
    busboy.on('file', function(fieldname, file, filename, encoding, mimetype) {

      console.log(`File [${fieldname}]: filename: ${filename}`)

      // 文件保存到特定路径
      file.pipe(fs.createWriteStream('./upload2'))

      // 开始解析文件流
      file.on('data', function(data) {
        console.log(`File [${fieldname}] got ${data.length} bytes`)
      })

      // 解析文件结束
      file.on('end', function() {
        console.log(`File [${fieldname}] Finished`)
      })

    })

    // 监听请求中的字段
    busboy.on('field', function(fieldname, val, fieldnameTruncated, valTruncated) {
      console.log(`Field [${fieldname}]: value: ${inspect(val)}`)
    })

    // 监听结束事件
    busboy.on('finish', function() {
      console.log('Done parsing form!')
      resolve({success:'success!'});
    })

    // busboy.on('error', reject({success:'failed!'}))
    // busboy.on('partsLimit', () => reject(new Error('LIMIT_PART_COUNT')))
    // busboy.on('filesLimit', () => reject(new Error('LIMIT_FILE_COUNT')))
    // busboy.on('fieldsLimit', () => reject(new Error('LIMIT_FIELD_COUNT')))

    req.pipe(busboy)
  });
}

var fn_uploadImg = async (ctx, next) => {

  let req = ctx.req;
  let result = await saveImg(req);
  ctx.body = result

}

module.exports = {
    'POST /uploadimage': fn_uploadImg
};