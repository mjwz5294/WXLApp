const Koa = require('koa');

const bodyParser = require('koa-bodyparser');

const controller = require('./controller');

const app = new Koa();

require('./Const');

// log request URL:
app.use(async (ctx, next) => {
    console.log(`Process ${ctx.request.method} ${ctx.request.url}...`);
    await next();
});

// parse request body:
app.use(bodyParser());

// add controllers:
app.use(controller('controllers'));



// const router = require('koa-router')(); 
// const send = require('koa-send'); // "koa-send": "^4.1.0"

// router.get('/', async function (ctx) {
//     var fileName = 'head.jpg';
//     await send(ctx, fileName, { root: __dirname + '/source/image' });
// });
// app.use(router.routes())





app.listen(3001);
console.log('image server started at port 3001...');