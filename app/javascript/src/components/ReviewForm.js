// # app/javascript/src/components/ReviewForm.js
import React, { useState } from 'react'

const ReviewForm = ({ airlineId, onReviewSubmitted, onCancel }) => {
  const [formData, setFormData] = useState({
    title: '',
    description: '',
    score: 5
  })
  const [errors, setErrors] = useState([])
  const [submitting, setSubmitting] = useState(false)

  const handleChange = (e) => {
    const { name, value } = e.target
    setFormData(prev => ({
      ...prev,
      [name]: name === 'score' ? parseInt(value) : value
    }))
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    setSubmitting(true)
    setErrors([])

    try {
      const response = await fetch(`/api/v1/airlines/${airlineId}/reviews`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ review: formData })
      })

      const data = await response.json()

      if (response.ok) {
        onReviewSubmitted()
      } else {
        setErrors(data.errors || ['Something went wrong'])
      }
    } catch (error) {
      console.error('Error submitting review:', error)
      setErrors(['Network error. Please try again.'])
    } finally {
      setSubmitting(false)
    }
  }

  const renderStars = (currentScore) => {
    const stars = []
    for (let i = 1; i <= 5; i++) {
      stars.push(
        <button
          key={i}
          type="button"
          className={`star-button ${i <= currentScore ? 'active' : ''}`}
          onClick={() => setFormData(prev => ({ ...prev, score: i }))}
        >
          ⭐
        </button>
      )
    }
    return stars
  }

  return (
    <div className="review-form-container">
      <form onSubmit={handleSubmit} className="review-form">
        <h3>Write a Review</h3>
        
        {errors.length > 0 && (
          <div className="errors">
            {errors.map((error, index) => (
              <p key={index} className="error">{error}</p>
            ))}
          </div>
        )}

        <div className="form-group">
          <label htmlFor="title">Review Title</label>
          <input
            type="text"
            id="title"
            name="title"
            value={formData.title}
            onChange={handleChange}
            required
            placeholder="Summarize your experience"
          />
        </div>

        <div className="form-group">
          <label htmlFor="score">Rating</label>
          <div className="star-rating">
            {renderStars(formData.score)}
            <span className="score-display">{formData.score}/5</span>
          </div>
        </div>

        <div className="form-group">
          <label htmlFor="description">Review Description</label>
          <textarea
            id="description"
            name="description"
            value={formData.description}
            onChange={handleChange}
            required
            placeholder="Tell us about your experience with this airline..."
            rows="5"
          />
        </div>

        <div className="form-actions">
          <button 
            type="button" 
            className="btn btn-secondary"
            onClick={onCancel}
          >
            Cancel
          </button>
          <button 
            type="submit" 
            className="btn btn-primary"
            disabled={submitting}
          >
            {submitting ? 'Submitting...' : 'Submit Review'}
          </button>
        </div>
      </form>
    </div>
  )
}

export default ReviewForm