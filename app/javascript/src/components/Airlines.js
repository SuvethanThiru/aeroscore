// # app/javascript/src/components/Airlines.js
import React, { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'

const Airlines = () => {
  const [airlines, setAirlines] = useState([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    fetchAirlines()
  }, [])

  const fetchAirlines = async () => {
    try {
      const response = await fetch('/api/v1/airlines')
      const data = await response.json()
      setAirlines(data)
      setLoading(false)
    } catch (error) {
      console.error('Error fetching airlines:', error)
      setLoading(false)
    }
  }

  const renderStars = (score) => {
    const stars = []
    for (let i = 1; i <= 5; i++) {
      stars.push(
        <span key={i} className={i <= score ? 'star filled' : 'star'}>
          ⭐
        </span>
      )
    }
    return stars
  }

  if (loading) {
    return <div className="loading">Loading airlines...</div>
  }

  return (
    <div className="airlines">
      <div className="container">
        <h2>All Airlines</h2>
        <div className="airlines-grid">
          {airlines.map(airline => (
            <Link to={`/airlines/${airline.id}`} key={airline.id} className="airline-card">
              <div className="airline-image">
                <img src={airline.image_url} alt={airline.name} />
              </div>
              <div className="airline-info">
                <h3>{airline.name}</h3>
                <p>{airline.description}</p>
                <div className="rating">
                  <div className="stars">
                    {renderStars(Math.round(airline.avg_score))}
                  </div>
                  <div className="score">{airline.avg_score || 0}/5</div>
                  <div className="reviews-count">
                    ({airline.reviews_count} reviews)
                  </div>
                </div>
              </div>
            </Link>
          ))}
        </div>
      </div>
    </div>
  )
}

export default Airlines