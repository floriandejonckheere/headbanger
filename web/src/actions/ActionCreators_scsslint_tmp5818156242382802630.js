import * as ActionTypes from 'actions/ActionTypes'

/**
 * App actions
 *
 */
export function setSelection(selection) {
  return {
    type: ActionTypes.SET_SELECTION,
    selection,
  }
}

export function clearSelection(selection) {
  return {
    type: ActionTypes.SET_SELECTION,
  }
}

export function setEdit(id, editType) {
  return {
    type: ActionTypes.SET_EDIT,
    editType,
    id,
  }
}

export function clearEdit() {
  return {
    type: ActionTypes.SET_EDIT,
  }
}
