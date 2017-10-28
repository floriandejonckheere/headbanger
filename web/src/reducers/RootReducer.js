import { combineReducers } from 'redux'
import { reducer as ApiReducer } from 'redux-bees'

import AppReducer from 'reducers/AppReducer'

const RootReducer = combineReducers({
  app: AppReducer,
  api: ApiReducer,
})

export default RootReducer
