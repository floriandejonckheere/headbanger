import React, { Component } from 'react'
import { Link } from 'react-router-dom'

import SearchbarContainer from 'components/navbar/searchbar/SearchbarContainer'

import './Navbar.css'

import logo from 'components/navbar/logo-inverse.png'

class Navbar extends Component {
  render() {
    return (
      <div className="hb-navbar uk-background-primary uk-light">
        <div className="uk-grid uk-flex-center@s uk-grid-collapse">
          <div className="uk-navbar-item hb-navbar-item uk-width-1-2@l uk-width-1-2@m">
            <div className="uk-flex-left">
              <a data-uk-toggle="target: #hb-nav-offcanvas" className="uk-logo uk-hidden@l">
                <img src={logo} alt="logo" className="hb-logo" />
              </a>
              <a href="/" className="uk-logo uk-visible@l">
                <img src={logo} alt="logo" className="hb-logo" /> <span className="hb-brand">Headbanger</span>
              </a>
            </div>
            <div className="hb-navbar-item uk-navbar-item uk-width-1-3@l uk-width-1-2@m uk-width-3-4 uk-visible@l">
              <SearchbarContainer />
            </div>
            <div className="hb-navbar-item uk-navbar-item uk-visible@m">
              <ul className="uk-nav uk-navbar-nav">
                <li className="uk-active"><Link to="/discover">Discover</Link></li>
                <li><Link to="/explore">Explore</Link></li>
                <li><Link to="/queue">Queue</Link></li>
              </ul>
            </div>
          </div>
        </div>

        <div id="hb-nav-offcanvas" data-uk-offcanvas="overlay: true">
          <div className="uk-offcanvas-bar uk-background-primary">
            <button className="uk-offcanvas-close uk-close uk-icon uk-light" type="button" data-uk-close />
            <ul className="uk-nav uk-nav-default uk-margin-bottom">
              <li className="uk-nav-header">Headbanger</li>
              <li className="uk-width-1-1 uk-padding-small uk-padding-remove-horizontal">
                <SearchbarContainer />
              </li>

              <li className="uk-nav-divider uk-margin-bottom" />
              <li className="uk-active"><Link to="/discover">Discover</Link></li>
              <li><Link to="/explore">Explore</Link></li>
              <li><Link to="/queue">Queue</Link></li>
            </ul>
          </div>
        </div>
      </div>
    )
  }
}

export default Navbar
