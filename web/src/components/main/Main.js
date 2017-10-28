import React, { Component } from 'react'

import './Main.css'

import Footer from 'components/main/Footer'

export default class Main extends Component {
  render() {
    return (
      <div className="hb-main uk-padding uk-height-1-1" data-uk-height-viewport="expand: true">
        { this.props.children }

        <Footer />
      </div>
    )
  }
}
