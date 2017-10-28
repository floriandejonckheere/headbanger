import React from 'react'
import ReactDOM from 'react-dom'

import UIkit from 'uikit/dist/js/uikit'
import Icons from 'uikit/dist/js/uikit-icons'

import 'typeface-montserrat'

import registerServiceWorker from './registerServiceWorker'

import './index.css'

import AppRouter from 'AppRouter'

// Active icons plugin
window.UIkit = UIkit
UIkit.use(Icons)

ReactDOM.render(<AppRouter />, document.getElementById('root'))
registerServiceWorker()
