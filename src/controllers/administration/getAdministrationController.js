const bcrypt = require('bcrypt');
const getAdministrationUserService = require('../../services/Administration/getAdministrationService');
const jwt = require('jsonwebtoken');
require('dotenv').config();


const getAdministrationLoginController = async (req, res) => {
    const { Mail, Password } = req.body;

    try {
        const adminUser = await getAdministrationUserService(Mail);
        if (adminUser && adminUser.length > 0) {
            const hashedPassword = adminUser[0].admin_password; 
            const match = await bcrypt.compare(Password, hashedPassword);
            if (match) {
                const token = jwt.sign(
                    { id: adminUser[0].admin_id, username: adminUser[0].admin_username },
                    process.env.JWT_SECRET,
                    { expiresIn: '1h' }
                );

                res.status(200).json({ message:"Login succesfull!", token });
            } else {
                res.status(401).send('Invalid Password');
            }
        } else {
            res.status(401).send('User not found');
        }
    } catch (err) {
        console.error('Error during login:', err);
        res.status(500).send('Internal Server Error');
    }
};


// getAdministrationLoginController(
//     {
//         body: {
//             Mail: 'jerycohe05@gmail.com',
//             Password: 'testpassword'
//         }
//     },
//     {
//         status: (code) => ({
//             send: (message) => console.log(`Response: ${code}, Message: ${message}`)
//         })
//     }
// );
module.exports = getAdministrationLoginController;