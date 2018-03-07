var fn_hello = async (ctx, next) => {
    ctx.response.body = `<h1>Hello, test!</h1>`;
};

module.exports = {
    'GET /hello/test': fn_hello
};