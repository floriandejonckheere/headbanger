import { connect } from 'react-redux'

import Api from 'api/Api'

import Searchbar from 'components/navbar/searchbar/Searchbar'

function mapStateToProps(state, ownProps) {
  return {
  }
}

function mapDispatchToProps(dispatch, ownProps) {
  return {
    doSearch: function(query) {
      dispatch(Api.search({ query }))
    }
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Searchbar)
