import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { query } from 'redux-bees'

import Api from 'api/Api'

import './Searchbar.css'

class Searchbar extends Component {
  constructor(props) {
    super(props)

    this.state = {
      query: ''
    }

    this.doSearch = this.doSearch.bind(this)
  }

  doSearch(event) {
    this.setState({ query: event.target.value })
    window.UIkit.dropdown('#dropdown-search').show()
    if (event.target.value.length > 0) {
      this.props.doSearch(event.target.value)
    }
  }

  render() {
    const { results } = this.props

    return (
      <div className="uk-width-1-1 uk-light uk-inline">
        <input
          type="search"
          className="uk-input uk-search-input re-searchbar"
          placeholder="Search artists, releases, genres"
          value={this.state.query}
          onChange={this.doSearch}
        />
        <div className="uk-width-1-1" id="dropdown-search" data-uk-dropdown="mode: none">
          { results &&
            console.log(results)
          }
        </div>
      </div>
    )
  }
}

Searchbar.propTypes = {
}

export default Searchbar
