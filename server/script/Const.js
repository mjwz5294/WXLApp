
//配置文件目录常量
global.rootDir = __dirname;
global.artDir = getSourceDir();
function getSourceDir(){
	var s = __dirname;
	s=s.substring(0,s.length-6)+'source';
	return s;
}

//配置数据库连接池常量
global.Sequelize = require('sequelize');
global.config = require('./config');
global.sequelize = new Sequelize(config.database, config.username, config.password, {
    host: config.host,
    dialect: 'mysql',
    pool: {
        max: 5,
        min: 0,
        idle: 30000
    }
});

//配置一些函数工具
global.typeTool = require('./utils/type');
global.datetimeTool = require('./utils/datetime');

module.exports = function() {
	
};