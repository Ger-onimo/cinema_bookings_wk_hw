
require_relative("../db/sql_runner")

class Ticket

  def initialize(options)
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values)[0]
    @id = ticket['id']
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    values = []
    tickets = SqlRunner.run(sql, values)
    result = tickets.map{ |ticket| Ticket.new(ticket)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    values = []
    SqlRunner.run(sql, values)
  end

  def customer()
    sql = "SELECT * FROM customers
    WHERE customers.id = $1"
    values = [@customer_id]
    customer_hash = SqlRunner.run(sql, values).first
    return Customer.new(customer_hash)
  end

  def film()
    sql = "SELECT * FROM films
    WHERE films.id = $1"
    values = [@film_id]
    film_hash = SqlRunner.run(sql, values).first
    return Film.new(film_hash)
  end

end
