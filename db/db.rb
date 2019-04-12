# frozen_string_literal: true

class DB
  def self.connect(db, table)
    database = Sequel.connect("sqlite://#{db}")
    database[table]
  end
end
