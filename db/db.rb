class DB
  def self.connect(db, table)
    database = Sequel.connect("sqlite://#{db}")
    database[table]
  end
end

