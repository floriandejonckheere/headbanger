import React, { Component } from 'react'

import './Main.css'

class Main extends Component {
  render() {
    return (
      <div className="hb-main uk-padding uk-height-1-1" data-uk-height-viewport="expand: true">
        <strong>Title</strong>

        <footer className="hb-footer uk-text-center uk-padding uk-padding-remove-horizontal uk-text-small">
          <a href="https://florian.dejonckhee.re/" className="uk-link-reset">&copy; 2017 Florian Dejonckheere</a>
        </footer>
      </div>
    )
  }
}

export default Main
