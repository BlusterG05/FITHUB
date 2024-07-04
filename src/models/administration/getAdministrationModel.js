const { query } = require('../../db/config');

const getAdministrationUser = async (email) => {
    console.log('Fetching user with email:', email);
    
    if (!email || typeof email !== 'string') {
        throw new Error('Invalid email provided');
    }

    const sql = `SELECT * FROM administration_users WHERE admin_email = $1;`;

    try {
        const res = await query(sql, [email]);
        return res.rows;
    } catch (err) {
        console.error('Error in query execution:', err.message);
        throw new Error('Error fetching email: ' + err.message);
    }
};

module.exports = getAdministrationUser;
