// # app/javascript/src/App.js
import React, { useState, useEffect } from 'react'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Airlines from './components/Airlines'
import Airline from './components/Airline'
import Header from './components/Header'

const App = () => {
  return (
    <Router>
      <div className="app">
        <Header />
        <div className="wrapper">
          <Routes>
            <Route path="/" element={<Airlines />} />
            <Route path="/airlines/:id" element={<Airline />} />
          </Routes>
        </div>
      </div>
    </Router>
  )
}

export default App