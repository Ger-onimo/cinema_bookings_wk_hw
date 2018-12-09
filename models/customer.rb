require('pg')
require_relative("../db/sql_runner")

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @funds = options['funds'].to_i
    @id = options['id'].to_i if options['id']
  end

  # def decrease_funds()


  # end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map{ |customer| Customer.new(customer)}
    return result
  end

# FOR PDA - SORT DATA REQUIREMENT
  def self.all_sorted_by_name()
    sql = "SELECT * FROM customers
    ORDER BY name"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map{ |customer| Customer.new(customer)}
    return result
  end


  def update()
    sql = "UPDATE customers
    SET
    (
      name,
      funds
    )=
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers
    WHERE id =$1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE tickets.customer_id = $1"
    values = [@id]
    film_hashes = SqlRunner.run(sql,values)
    return film_hashes.map { |film| Film.new(film)  }
  end

# EXT
  def reduce_funds(price)
    @funds -= price
  end
  # REVIEW: works using console test, but can't see result in postico table

  def ticket_count()
    sql = "SELECT COUNT (tickets.*) FROM tickets
      WHERE tickets.customer_id = $1"
      values = [@id]
      result = SqlRunner.run(sql, values)[0].first
      return result
  end
  # REVIEW: had trouble with result. Not quite there with the understanding
  # seems you can use [0] as well as .first. But I get a hash and that's
  # not really a count....
end
