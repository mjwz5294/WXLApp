const Article = require('../models/article');
const fs = require('fs');

var getArts = async ( ctx ) => {
	var arts = await Article.findAll({});
	for (var i = 0; i < arts.length; i++) {
		let art = arts[i];
		let contentStr = fs.readFileSync(artDir+art.title, 'utf-8');
    	art.dataValues.contentStr = contentStr;
	};
	ctx.rest({
	    data: arts
	});
}

/*
id:文章id
*/
var getArtWithId = async ( ctx ) => {
	let artId = ctx.params.artId
	var arts = await Article.findAll({
        where: {
            id: artId
        }
    });
    
    if (arts&&arts[0]) {
    	let art = arts[0];
    	var contentStr = fs.readFileSync(artDir+art.title, 'utf-8');
    	art.dataValues.contentStr = contentStr;
    	ctx.rest({
		    data: art
		});
    }else{
    	ctx.rest({
		    data: {result:'没查到'}
		});
    }
}

/*
writer:写入表
title:写入表，并作为文件名
contentStr:文章内容，应该是一个数组，拼接好后写入文件
*/
var createArt = async ( ctx ) => {
	let postData = ctx.request.body

	fs.writeFileSync(artDir+postData.title, postData.contentStr);

	var art = await Article.create({
        writer: postData.writer,
        title: postData.title,
        create_time: Date.now(),
        modified_time: Date.now()
    });
    art.contentStr	 = postData.contentStr;

	ctx.rest({
	    data: art
	});
}

/*
id:文章id
title:写入表，并作为文件名
contentStr:文章内容
*/
var editArt = async ( ctx ) => {
	let postData = ctx.request.body

	fs.writeFileSync(artDir+postData.title, postData.contentStr);

	var pram={
        title: postData.title,
        modified_time: Date.now()
    };
	var success = await Article.update(pram,{
		where:{'id':postData.id}
	});

	ctx.rest({
	    data: {success:success}
	});
}

/*
id:文章id
*/
var delArt = async ( ctx ) => {
	let postData = ctx.request.body

	fs.unlinkSync(artDir+postData.title);

	var success = await Article.destroy({'where':{'id':postData.id}})
	ctx.rest({
	    data: {success:success}
	});
}

module.exports = {
    'GET /api/articles/getArt': getArts,
    'GET /api/articles/getArt/:artId': getArtWithId,
    'POST /api/articles/createArt': createArt,
    'POST /api/articles/editArt': editArt,
    'POST /api/articles/delArt': delArt,
};

