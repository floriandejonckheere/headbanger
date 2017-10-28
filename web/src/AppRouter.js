import React, { Component } from 'react'
import { Route, Switch } from 'react-router'
import { BrowserRouter } from 'react-router-dom'
import { Provider } from 'react-redux'

import store from 'store'

import Navbar from 'components/navbar/Navbar'
import Main from 'components/main/Main'

import Home from 'components/pages/Home'
import Discover from 'components/pages/Discover'

export default class AppRouter extends Component {
  render() {
    return (
      <Provider store={store}>
        <BrowserRouter>
          <div>
            <Navbar />

            <div className="uk-grid uk-flex-center uk-grid-collapse">
              <div className="uk-width-1-2@l uk-width-1-2@m">
                <Main>
                  <Switch>
                    <Route exact path="/" component={Home}>
                      <Route exact path="/discover" component={Discover}/>
                      <Route exact path="/explore" component={Explore}/>
                    </Route>
                  </Switch>
                </Main>
              </div>
            </div>
          </div>
        </BrowserRouter>
      </Provider>
    )
  }
}
