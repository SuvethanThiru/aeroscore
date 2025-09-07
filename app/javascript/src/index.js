// # app/javascript/src/index.js
import React from 'react'
import ReactDOM from 'react-dom'
import App from './App'
import '../stylesheets/application.scss'

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <App />,
    document.getElementById('root')
  )
})