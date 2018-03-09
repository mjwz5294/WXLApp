var posttest = async ( ctx ) => {

  // 当POST请求的时候，解析POST表单里的数据，并显示出来
  let postData = ctx.request.body
  ctx.body = postData
    
}

module.exports = {
    'POST /postTest': posttest
};

