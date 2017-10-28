import { connect } from 'react-redux'
import { setFilter } from 'actions/ActionCreators'

import * as Constants from 'actions/Constants'
import Searchbar from 'components/navbar/searchbar/Searchbar'

function mapStateToProps(state, ownProps) {
  return {
  }
}

function mapDispatchToProps(dispatch, ownProps) {
  return {
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Searchbar)
