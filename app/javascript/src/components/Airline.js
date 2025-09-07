// # app/javascript/src/components/Airline.js
import React, { useState, useEffect } from 'react'
import { useParams } from 'react-router-dom'
import ReviewForm from './ReviewForm'

const Airline = () => {
  const { id } = useParams()
  const [airline, setAirline] = useState(null)
  const [loading, setLoading] = useState(true)
  const [showReviewForm, setShowReviewForm] = useState(false)

  useEffect(() => {
    fetchAirline()
  }, [id])

  const fetchAirline = async () => {
    try {
      const response = await fetch(`/api/v1/airlines/${id}`)
      const data = await response.json()
      setAirline(data)
      setLoading(false)
    } catch (error) {
      console.error('Error fetching airline:', error)
      setLoading(false)
    }
  }

  const handleReviewSubmitted = () => {
    setShowReviewForm(false)
    fetchAirline() // Refresh airline data
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
    return <div className="loading">Loading airline details...</div>
  }

  if (!airline) {
    return <div className="error">Airline not found</div>
  }

  return (
    <div className="airline-detail">
      <div className="container">
        <div className="airline-header">
          <img src={airline.image_url} alt={airline.name} className="airline-logo" />
          <div className="airline-info">
            <h1>{airline.name}</h1>
            <p>{airline.description}</p>
            <div className="rating-summary">
              <div className="stars">
                {renderStars(Math.round(airline.avg_score))}
              </div>
              <div className="score">{airline.avg_score}/5</div>
              <div className="reviews-count">
                ({airline.reviews ? airline.reviews.length : 0} reviews)
              </div>
            </div>
          </div>
        </div>

        <div className="reviews-section">
          <div className="reviews-header">
            <h2>Reviews</h2>
            <button 
              className="btn btn-primary"
              onClick={() => setShowReviewForm(true)}
            >
              Write a Review
            </button>
          </div>

          {showReviewForm && (
            <ReviewForm 
              airlineId={id}
              onReviewSubmitted={handleReviewSubmitted}
              onCancel={() => setShowReviewForm(false)}
            />
          )}

          <div className="reviews-list">
            {airline.reviews && airline.reviews.length > 0 ? (
              airline.reviews.map(review => (
                <div key={review.id} className="review-card">
                  <div className="review-header">
                    <h3>{review.title}</h3>
                    <div className="review-rating">
                      {renderStars(review.score)}
                      <span className="score">{review.score}/5</span>
                    </div>
                  </div>
                  <p className="review-description">{review.description}</p>
                  <div className="review-date">{review.created_at}</div>
                </div>
              ))
            ) : (
              <div className="no-reviews">
                No reviews yet. Be the first to review this airline!
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}

export default Airline