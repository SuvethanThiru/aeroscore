// # app/javascript/src/components/Header.js
import React from 'react'
import { Link } from 'react-router-dom'

const Header = () => {
  return (
    <div className="wrapper">
      <header className="header">
        <Link to="/" className="logo">
          <h1>✈️ AeroScore</h1>
        </Link>
        <p>Discover and review airlines</p>
      </header>
    </div>
  )
}

export default Header