

const Article = sequelize.define('articles', {
    id: {
        type: Sequelize.BIGINT,
        primaryKey: true,
        autoIncrement: true
    },
    writer: Sequelize.STRING(100),
    create_time: Sequelize.BIGINT,
    modified_time: Sequelize.BIGINT
}, {
        timestamps: false
    });

module.exports = Article