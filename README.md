# Quinyx Warrior

## Server
Backend build in node.js using coffee script. Integration with spread sheet using npm module 'google-spreadsheet'.

### To run
```
cd server
npm install
// make a copy of config.dev.js.default (instructions in file)
// get the private key for the google service account and use it
npm start
```

### To publish
The backend is hosted at heroku, deploys are made using git.

```
// make your changes and make sure they run locally
// stand in the quinxy-worrior directory (not in server)
git subtree push --prefix server heroku master
// Why we're using subtree: http://stackoverflow.com/q/5977234/416797
```

## Client
Frontend build in React with Redux using coffee script.

### To run
```
cd client
npm install
// make a copy of config.dev.js.default (instructions in file)
npm start
```

### To publish
The frontend is hosted at firebase, deploys are made using firebase-toolbelt.

```
cd client
npm run build
firebase deploy
```


## TODO
 - [ ] Implement login with quinyx google account: https://marvelapp.com/194gbd4#9994757
 - [ ] Implement daily view: https://marvelapp.com/194gbd4#10622697
 - [ ] Implement report view (inkludes backend): https://marvelapp.com/194gbd4#9994755
 - [ ] Fix incorrect widths based on numbers reported
 - [ ] When clicking on filters (steps, crunches, pushups, pullups) we're only ordering. We should probably also filter on only the kind of workout you selected. 
 - [ ] Systems architecture exposed at docku.firebaseapp.com
