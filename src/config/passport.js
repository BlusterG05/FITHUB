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
  let userToSerialize = Array.isArray(user) ? user[0] : user;
  
  if (userToSerialize && userToSerialize.admin_id) {
      done(null, userToSerialize.admin_id);
  } else {
      console.error('Invalid user object:', userToSerialize);
      done(new Error('Invalid user object during serialization'));
  }
});

passport.deserializeUser(async function(id, done) {
  try {
      const user = await getAdministrationService(id);
      if (user) {
          done(null, user);
      } else {
          done(new Error('User not found'));
      }
  } catch (error) {
      done(error);
  }
});
module.exports = passport;