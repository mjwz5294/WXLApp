const Article = require('../models/article');

var getArts = async ( ctx ) => {
	var arts = await Article.findAll({});
	ctx.rest({
	    data: arts
	});
}

var getArtWithId = async ( ctx ) => {
	let getData = ctx.params.artId
	var art = await Article.findAll({
        where: {
            id: getData
        }
    });
    console.log('getArtWithId---',art);
    if (art) {
    	ctx.rest({
		    data: art
		});
    }else{
    	ctx.rest({
		    data: {result:'没查到'}
		});
    }
}

var createArt = async ( ctx ) => {
	let postData = ctx.request.body

	var art = await Article.create({
        writer: postData.writer,
        create_time: '2008-08-08',
        modified_time: '2008-08-08'
    });

	ctx.rest({
	    data: art
	});
}

var editArt = async ( ctx ) => {
	let postData = ctx.request.body

	var pram={
        writer: 'wwwxxxlll',
        create_time: '2008-08-09',
        modified_time: '2008-08-09'
    };
	var art = await Article.update(pram,{
		where:{'id':postData.id}
	});

	ctx.rest({
	    data: {success:art}
	});
}

var delArt = async ( ctx ) => {
	let postData = ctx.request.body

	var art = await Article.destroy({'where':{'id':postData.id}})
	ctx.rest({
	    data: {success:art}
	});
}

module.exports = {
    'GET /api/articles/getArt': getArts,
    'GET /api/articles/getArt/:artId': getArtWithId,
    'POST /api/articles/createArt': createArt,
    'POST /api/articles/editArt': editArt,
    'POST /api/articles/delArt': delArt,
};

