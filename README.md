# world_cup_api
A basic API for managing World Cup data, offering endpoints to retrieve match details and country information based on provided CSV files

* Ruby version
3.0.0

* Rails version
7.0.8

## API Endpoints

### Matches

1. **Show a single match**
   - **GET** `/matches/:id`
   - **Description**: Retrieves details for a single match, including home and away countries, scores, date, venue, and round.
   - **Response Example**:
     ```json
     {
       "match": {
         "home_country": "Argentina",
         "away_country": "France",
         "home_score": 3,
         "away_score": 2,
         "date": "2022-12-18",
         "venue": "Lusail Iconic Stadium",
         "round": "Final"
       }
     }
     ```

2. **List all matches**
   - **GET** `/matches`
   - **Description**: Retrieves a list of all matches played in the tournament.
   - **Response Example**:
     ```json
     [
       {
         "id": 1,
         "home_country": "Argentina",
         "away_country": "France",
         "home_score": 3,
         "away_score": 2,
         "date": "2022-12-18",
         "venue": "Lusail Iconic Stadium",
         "round": "Final"
       },
       ...
     ]
     ```

3. **Create a new match**
   - **POST** `/matches`
   - **Description**: Creates a new match with the provided details.
   - **Request Body Example**:
     ```json
     {
       "home_country_id": 1,
       "away_country_id": 2,
       "home_score": 3,
       "away_score": 2,
       "date": "2022-12-18",
       "venue": "Lusail Iconic Stadium",
       "round": "Final"
     }
     ```
   - **Response Example**:
     ```json
     {
       "match": {
         "id": 3,
         "home_country": "Argentina",
         "away_country": "France",
         "home_score": 3,
         "away_score": 2,
         "date": "2022-12-18",
         "venue": "Lusail Iconic Stadium",
         "round": "Final"
       }
     }
     ```

4. **Update a match**
   - **PUT** `/matches/:id`
   - **Description**: Updates an existing match with the provided details.
   - **Request Body Example**:
     ```json
     {
       "home_score": 4,
       "away_score": 2
     }
     ```
   - **Response Example**:
     ```json
     {
       "match": {
         "id": 1,
         "home_country": "Argentina",
         "away_country": "France",
         "home_score": 4,
         "away_score": 2,
         "date": "2022-12-18",
         "venue": "Lusail Iconic Stadium",
         "round": "Final"
       }
     }
     ```

### Countries

1. **Show basic info for a country**
   - **GET** `/countries/:id`
   - **Description**: Retrieves basic information for a specified country, including country abbreviation and full country name. Optionally includes a list of matches the country has participated in (both home and away).
   - **Query Parameter**: 
     - `includeMatches`: If set to `true`, includes a list of matches.
   - **Response Example** (without matches):
     ```json
     {
       "country_name": "Argentina",
       "country_code": "ARG"
     }
     ```
   - **Response Example** (with matches):
     ```json
     {
       "country_name": "Argentina",
       "country_code": "ARG",
       "home_matches": [...],
       "away_matches": [...]
     }
     ```

## Error Handling

The API handles various errors with appropriate status codes and messages:
- **404 Not Found**: When a match or country with the specified ID does not exist.
- **422 Unprocessable Entity**: When validation fails on creating or updating a match.
- **500 Internal Server Error**: For unexpected errors during processing.

## Getting Started

1. **Clone the repository**
2. **Install dependencies**:
    - To install dependencies, run: `bundle install`
3. **Set up the database**:
    - Create the database using: `rails db:create`
    - To run migrations: `rails db:migrate`
4. **Seed the database with CSV data**:
    - To import match data into the database, run: `rails import:matches`
    - To import country data into the database, run: `rails import:countries`
5. **Start the server**:
    `rails server`

## Testing

To run the test cases, run this command: `bundle exec rspec`