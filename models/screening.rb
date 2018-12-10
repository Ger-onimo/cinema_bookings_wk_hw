# Advanced Extension
require('pg')
require_relative("../db/sql_runner")

class Screening
  attr_accessor :screening_time
  attr_reader :id, :film_id

  def initialize(options)
    @screening_time = options['screening_time']
    @film_id = options['film_id'].to_i       #Adv Ext
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO screenings
    (
      screening_time
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = [@screening_time]
    time = SqlRunner.run(sql, values).first
    @id = time['id'].to_i
  end

    def self.all()
      sql = "SELECT * FROM screenings"
      values = []
      screenings = SqlRunner.run(sql, values)
      result = screenings.map{ |screening| Screening.new(screening)}
      return result
    end

    # def update()
    #   sql = "UPDATE screenings
    #   SET
    #   (
    #     screening_time
    #   ) =
    #   (
    #     $1
    #   )
    #   WHERE id = $2"
    #   values = [@screening_time, @id]
    #   SqlRunner.run(sql, values)
    # end

    def self.delete_all()
      sql = "DELETE FROM screenings"
      values = []
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "DELETE FROM screenings
      WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end

#Adv Ext
    def film()
      sql = "SELECT * FROM films
      WHERE id = $1"
      values = [@film_id]
      film_hash = SqlRunner.run(sql, values).first
      return Film.new(film_hash)
    end

end
