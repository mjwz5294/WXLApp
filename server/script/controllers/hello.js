var fn_hello = async (ctx, next) => {
    var name = ctx.params.name;
    // ctx.response.body = `<h1>Hello, ${name}!</h1>`;
    ctx.rest({
	    data: 123
	});
};

module.exports = {
    'GET /api/hello/:name': fn_hello
};