{combineReducers} = require 'redux'
url = require './url'
{sync_workout} = require './sync'
workouts = require './workouts'
users = require './users'

rootReducer = combineReducers {url, sync_workout, workouts, users}

module.exports = rootReducer
