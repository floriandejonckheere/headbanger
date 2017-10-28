import { combineReducers } from 'redux'

import AppReducer from 'reducers/AppReducer'

const RootReducer = combineReducers({
  app: AppReducer,
})

export default RootReducer
