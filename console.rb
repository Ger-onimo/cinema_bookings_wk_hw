require('pry')
require('pg')

require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

Customer.delete_all
Film.delete_all
Ticket.delete_all

customer1 = Customer.new( {'name' => 'Sue', 'funds' => '15'})
customer1.save
customer2 = Customer.new( {'name' => 'Hardy', 'funds' => '20'})
customer2.save
customer3 = Customer.new( {'name' => 'Heather', 'funds' => '10'})
customer3.save
customer4 = Customer.new( {'name' => 'Amy', 'funds' => '50'})
customer4.save
customer5 = Customer.new( {'name' => 'Zed', 'funds' => '25'})
customer5.save

film1 = Film.new( {'title' => 'Apocalypse Now', 'price' => '5'})
film1.save
film2 = Film.new( {'title' => 'The Departed', 'price' => '5'})
film2.save
film3 = Film.new( {'title' => 'Some Like It Hot', 'price' => '3'})
film3.save

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save
ticket2 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket2.save
ticket3 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket3.save
ticket4 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket4.save
ticket5 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film1.id})
ticket5.save

# customer2.delete
# film3.delete

Customer.all
Film.all
Ticket.all

customer1.reduce_funds(film1.price) # EXT
customer1.ticket_count # EXT
film1.customer_count # EXT

# customer1.funds = '40'
# customer1.update
# film1.price = '8'
# film1.update

binding.pry
nil
