import React, { Component } from 'react'

import SearchbarContainer from 'components/navbar/searchbar/SearchbarContainer'

import './Navbar.css'

import logo from 'components/navbar/logo-inverse.png'

class Navbar extends Component {
  render() {
    return (
      <div className="hb-navbar uk-background-primary">
        <div className="uk-grid uk-flex-center@s uk-grid-collapse">
          <div className="uk-navbar-item hb-navbar-item uk-flex-left">
            <a data-uk-toggle="target: #hb-nav-offcanvas" className="uk-logo uk-hidden@s">
              <img src={logo} alt="logo" className="hb-logo" /> <span className="hb-brand">Headbanger</span>
            </a>
            <a href="/" className="uk-logo uk-visible@s">
              <img src={logo} alt="logo" className="hb-logo" /> <span className="hb-brand">Headbanger</span>
            </a>
          </div>
          <div className="uk-navbar-item hb-navbar-item uk-width-1-3@l uk-width-1-2@m uk-width-3-4 uk-visible@s">
            <SearchbarContainer />
          </div>
        </div>

        <div id="hb-nav-offcanvas" data-uk-offcanvas="overlay: true">
          <div className="uk-offcanvas-bar uk-background-primary">
            <button className="uk-offcanvas-close uk-close uk-icon uk-light" type="button" data-uk-close />
            <ul className="uk-nav uk-nav-default">
              <li className="uk-nav-header">Headbanger</li>
              <li className="uk-width-1-1"><SearchbarContainer /></li>
            </ul>
          </div>
        </div>
      </div>
    )
  }
}

export default Navbar
