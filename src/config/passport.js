// config/passport.js
const getAdministrationService = require('../services/Administration/getAdministrationService');
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;
const findOrCreateUser = require('../oauth/oauthUserHandler');

passport.use(new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: "http://localhost:3000/auth/callback"
  },
  async function(accessToken, refreshToken, profile, cb) {
    try {
      const user = await findOrCreateUser({
        name: profile.displayName,
        email: profile.emails[0].value,
        username: profile.emails[0].value.split('@')[0]
      });
      return cb(null, user);
    } catch (error) {
      return cb(error);
    }
  }
));

passport.serializeUser(function(user, done) {
    console.log('Serializing user:', user);
    done(null, user.admin_email); // Asume que el objeto de usuario tiene una propiedad admin_email
  });

  passport.deserializeUser(async function(id, done) {
    console.log('Deserializing user ID:', id);
    try {
      const user = await getAdministrationService(id);
      console.log('Deserialized user:', user);
      done(null, user[0]);
    } catch (error) {
      console.error('Error deserializing user:', error);
      done(error);
    }
  });
module.exports = passport;