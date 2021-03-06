const Koa = require('koa');

const bodyParser = require('koa-bodyparser');

const Const = require('./Const.js');

const controller = require('./controller');

const rest = require('./rest');

const app = new Koa();

// log request URL:
app.use(async (ctx, next) => {
    console.log(`Process ${ctx.request.method} ${ctx.request.url}...`);
    await next();
});

app.use(rest.restify());

// parse request body:
app.use(bodyParser());

// add controllers:
app.use(controller('controllers'));

app.listen(3000);
console.log('app started at port 3000...');