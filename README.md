# README

* Ruby Version 2.7.0

* Rails Version 6.0.3

#### Instructions

* Take Clone from the git repository
* Install ruby-2.7.0 using rvm
* Run `bundle install`
* Add `master.key` file in `config` folder.
* Run the test suite using `rspec`.
* Run `rails s` to start the server.
* Test the application by visiting http://localhost:3000/


#### Explaination

* The authentication is done using the devise gem along with reset password functionality.
* To check emails Visit the url http://localhost:3000/letter_opener  in development mode.
* Using "I am feeling lucky" (Bonus task) button present next to the search page where the user can get the results by clicking on "I am feeling lucky", the results contain all new results which is not present in the user histories.
* A logged in User can check his/her search history, the page has query and result histories on this page.
* A seprate search page has been created, where logged in user can search for Channel, the result list display thubmnail, title, language and streaming time. These results are also cached into the DB as user search history.
* The search results details contains the profile details and a badge indicating if the channel is in top 20 postions.
* Test cases are added for the respective functionalities.

### Limitations
* All the  records can be cached/stored into a NoSQL database like mongo:db. I would preferred redis for this solution however for the time constraint, I have used the postgress.
* Since the API return the data in a specific order, I have implemented pagination logic for not repeating the results. The pagination is no more supported for channel search API.

### Can be done.
* Implement Redis for better performance
* User's search history should also moved to Redis or any NoSQL DB for better performance
