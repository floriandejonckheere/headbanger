import { createStore, applyMiddleware } from 'redux'
import { middleware as ApiMiddleware } from 'redux-bees'

import RootReducer from 'reducers/RootReducer'

export default createStore(
  RootReducer,
  window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__(),
  applyMiddleware(ApiMiddleware()),
)
