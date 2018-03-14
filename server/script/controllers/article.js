const Article = require('../models/article');
const fs = require('fs');

//tools
function getClearTitle(artModel){
	let titleArr = artModel.dataValues.title.split('---');
	return titleArr[0];
}

function getBackArtjson(artModel,contentStr,title){
	backArt = artModel.dataValues;
	backArt.contentStr = contentStr;
	backArt.title = title;
	return backArt;

}

//获取文章列表
var getArts = async ( ctx ) => {
	var arts = await Article.findAll({});
	let backArts = [];
	for (var i = 0; i < arts.length; i++) {
		let art = arts[i];
		let contentStr = fs.readFileSync(artDir+art.title, 'utf-8');
		let backArt = getBackArtjson(art,contentStr,getClearTitle(art));
		backArts.push(backArt);
	};

	ctx.rest({
		code: 'ERROR_NOERROR',
	    data: {
	    	message:commonCode.ERROR_NOERROR,
    		returnData: {
    			artArr:backArts
    		},
    		stateCode: 'ERROR_NOERROR'
	    }
	});
}

/*
id:文章id
*/
var getArtWithId = async ( ctx ) => {
	let artId = ctx.request.query.artId
	var arts = await Article.findAll({
        where: {
            id: artId
        }
    });
    
    let art = arts[0];
	var contentStr = fs.readFileSync(artDir+art.title, 'utf-8');
	let backArt = getBackArtjson(art,contentStr,getClearTitle(art));

	ctx.rest({
		code: 'ERROR_NOERROR',
	    data: {
	    	message:commonCode.ERROR_NOERROR,
    		returnData: backArt,
    		stateCode: 'ERROR_NOERROR'
	    }
	});
}

/*
writer:写入表
title:写入表，并作为文件名
contentStr:文章内容，应该是一个数组，拼接好后写入文件
*/
var createArt = async ( ctx ) => {
	let postData = ctx.request.body
	let saveTitle = postData.title+'---'+Date.now()

	fs.writeFileSync(artDir+saveTitle, postData.contentStr);

	var art = await Article.create({
        writer: postData.writer,
        title: saveTitle,
        create_time: Date.now(),
        modified_time: Date.now()
    });

    let backArt = getBackArtjson(art,postData.contentStr,postData.title);

	ctx.rest({
		code: 'ERROR_NOERROR',
	    data: {
	    	message:commonCode.ERROR_NOERROR,
    		returnData: backArt,
    		stateCode: 'ERROR_NOERROR'
	    }
	});
}

/*
id:文章id
title:写入表，并作为文件名
contentStr:文章内容
*/
var editArt = async ( ctx ) => {
	let postData = ctx.request.body

	let artId = postData.artId
	var arts = await Article.findAll({
        where: {
            id: artId
        }
    });
    let art = arts[0];
    let saveTitle = art.dataValues.title;

	fs.writeFileSync(artDir+saveTitle, postData.contentStr);

	var pram={
        title: saveTitle,
        modified_time: Date.now()
    };
	var success = await Article.update(pram,{
		where:{'id':artId}
	});

	ctx.rest({
		code: 'ERROR_NOERROR',
	    data: {
	    	message:commonCode.ERROR_NOERROR,
    		stateCode: 'ERROR_NOERROR'
	    }
	});
}

/*
id:文章id
*/
var delArt = async ( ctx ) => {
	let postData = ctx.request.body

	let artId = postData.artId
	var arts = await Article.findAll({
        where: {
            id: artId
        }
    });
    let art = arts[0];

	fs.unlinkSync(artDir+art.title);

	var success = await Article.destroy({'where':{'id':postData.artId}})

	ctx.rest({
		code: 'ERROR_NOERROR',
	    data: {
	    	message:commonCode.ERROR_NOERROR,
    		stateCode: 'ERROR_NOERROR'
	    }
	});
}

module.exports = {
    'GET /api/articles/getArt': getArts,
    'GET /api/articles/getArtWithId': getArtWithId,
    'POST /api/articles/createArt': createArt,
    'POST /api/articles/editArt': editArt,
    'POST /api/articles/delArt': delArt,
};

