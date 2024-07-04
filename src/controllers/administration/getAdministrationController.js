
const getAdministrationUserService = require('../../services/Administration/getAdministrationService');

const getAdministrationLoginController = async (req, res) => {
    const { Mail, Password } = req.body;

    try {
        const adminUser = await getAdministrationUserService(Mail);
        if (adminUser && adminUser.length > 0) {
            //console.log("Username: " + adminUser[0].admin_username);
            res.status(200).send("Username: " + adminUser[0].admin_username);
        } else {
            //console.log('No user found');
            res.status(401).send('User dont found');
        }
    } catch (err) {
        console.error('User Doesnt exist: ' + err.message);
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