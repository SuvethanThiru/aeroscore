# README.md
# AeroScore - Airline Review Web Application

AeroScore is a full-stack web application built with Ruby on Rails and React that allows users to discover airlines and write reviews about their flight experiences.

## Technologies Used

- **Backend**: Ruby on Rails 7.0
- **Frontend**: React 18 with React Router
- **Database**: PostgreSQL
- **Asset Management**: Webpacker 5.0
- **Styling**: SCSS with modern CSS Grid and Flexbox
- **Testing**: RSpec with FactoryBot

## Features

- 📊 Browse airlines with average ratings and review counts
- ✈️ View detailed airline information and reviews
- ✍️ Write and submit reviews with 1-5 star ratings
- 📱 Responsive design for mobile and desktop
- 🎨 Modern UI with gradients and smooth animations
- ⚡ Optimized asset management with Webpacker
- 🧪 Comprehensive test suite with RSpec

## Installation & Setup

### Prerequisites
- Ruby 3.0.0+
- Rails 7.0+
- PostgreSQL
- Node.js and Yarn
- Git

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/aeroscore.git
   cd aeroscore
   ```

2. **Install dependencies**
   ```bash
   bundle install
   yarn install
   ```

3. **Database setup**
   ```bash
   # Create and setup database
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the servers**
   ```bash
   # In one terminal - Rails server
   rails server

   # In another terminal - Webpacker dev server
   ./bin/webpack-dev-server
   ```

5. **Visit the application**
   Open your browser and navigate to `http://localhost:3000`

## Project Structure

```
aeroscore/
├── app/
│   ├── controllers/
│   │   ├── api/v1/           # API controllers
│   │   └── home_controller.rb
│   ├── models/
│   │   ├── airline.rb
│   │   └── review.rb
│   ├── javascript/
│   │   ├── src/              # React components
│   │   ├── stylesheets/      # SCSS files
│   │   └── packs/            # Webpacker entry points
│   └── views/
├── config/
│   ├── database.yml
│   ├── routes.rb
│   └── webpacker.yml
├── db/
│   ├── migrate/
│   └── seeds.rb
├── spec/                     # RSpec tests
└── package.json
```

## API Endpoints

### Airlines
- `GET /api/v1/airlines` - List all airlines
- `GET /api/v1/airlines/:id` - Get specific airline with reviews
- `POST /api/v1/airlines` - Create new airline
- `PUT /api/v1/airlines/:id` - Update airline
- `DELETE /api/v1/airlines/:id` - Delete airline

### Reviews
- `GET /api/v1/airlines/:airline_id/reviews` - List airline reviews
- `POST /api/v1/airlines/:airline_id/reviews` - Create new review
- `PUT /api/v1/airlines/:airline_id/reviews/:id` - Update review
- `DELETE /api/v1/airlines/:airline_id/reviews/:id` - Delete review

## Testing

Run the test suite:
```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/airline_spec.rb

# Run tests with coverage
bundle exec rspec --format documentation
```

## Database Schema

### Airlines Table
- `id` (Primary Key)
- `name` (String, Required, Unique)
- `image_url` (Text, Required)
- `description` (Text)
- `created_at` (Timestamp)
- `updated_at` (Timestamp)

### Reviews Table  
- `id` (Primary Key)
- `title` (String, Required)
- `description` (Text, Required)
- `score` (Integer, Required, 1-5)
- `airline_id` (Foreign Key)
- `created_at` (Timestamp)
- `updated_at` (Timestamp)

## Deployment

### Environment Variables
Set the following environment variables in production:
- `DATABASE_PASSWORD` - PostgreSQL password
- `RAILS_MASTER_KEY` - Rails master key for credentials
- `RAILS_SERVE_STATIC_FILES` - Set to true for static file serving

### Production Build
```bash
# Precompile assets
RAILS_ENV=production bundle exec rails assets:precompile

# Run database migrations
RAILS_ENV=production bundle exec rails db:migrate
```
