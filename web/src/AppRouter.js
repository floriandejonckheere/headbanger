import React, { Component } from 'react'
import { Route, Switch } from 'react-router'
import { BrowserRouter } from 'react-router-dom'
import { Provider } from 'react-redux'

import App from 'components/app/App'
import store from 'store'

class AppRouter extends Component {
  render() {
    return (
      <Provider store={store}>
        <BrowserRouter>
          <Switch>
            <Route exact path="/" component={App}/>
          </Switch>
        </BrowserRouter>
      </Provider>
    )
  }
}

export default AppRouter
