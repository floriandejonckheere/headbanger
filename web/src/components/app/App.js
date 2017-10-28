import React, { Component } from 'react'

import './App.css'

class App extends Component {
  render() {
    return (
      <div>
        <Navbar />
        <div className="uk-grid uk-flex-center uk-grid-collapse">
          <div className="uk-width-1-2@l uk-width-1-2@m">
            <MainContainer />
          </div>
        </div>
      </div>
    );
  }
}

export default App
