require("pg")

class PropertyListing

attr_accessor :address, :beds, :year_built, :buy_let_status
attr_reader :id

def initialize(options)
  @address = options['address']
  @beds = options['beds'].to_i
  @year_built = options['year_built'].to_i
  @buy_let_status = options['buy_let_status']
  @id = options['id'].to_i if options['id']
end

def save()
  db = PG.connect( {dbname: 'property_tracker', host: 'localhost'} )
  sql = "INSERT INTO property_listings
  (address, beds, year_built, buy_let_status)
  VALUES ($1, $2, $3, $4)
  RETURNING *;"
  values = [@address, @beds, @year_built, @buy_let_status]
  db.prepare("save", sql)
  result = db.exec_prepared("save", values)
  @id = result[0]["id"].to_i
  db.close
end

def update()
  db = PG.connect( {dbname: 'property_tracker', host: 'localhost'} )
  sql = "UPDATE property_listings
  SET
  (address, beds, year_built, buy_let_status)
  = ($1, $2, $3, $4)
  WHERE id = $5"
  values = [@address, @beds, @year_built, @buy_let_status, @id]
  db.prepare("update", sql)
  db.exec_prepared("update", values)
  db.close
end

def delete()
  db = PG.connect( {dbname: 'property_tracker', host: 'localhost'} )
  sql = "DELETE FROM property_listings
  WHERE id = $1;"
  values = [@id]
  db.prepare("delete_one", sql)
  db.exec_prepared("delete_one", values)
  db.close
end

def PropertyListing.find(id)
  db = PG.connect( {dbname: 'property_tracker', host: 'localhost'} )
  sql = "SELECT * FROM property_listings WHERE id = $1"
  values = [id]
  db.prepare("find_one", sql)
  result = db.exec_prepared("find_one", values)
  db.close
  return result.map { |result| PropertyListing.new(result)}
end

def PropertyListing.find_by_address(address)
  db = PG.connect( {dbname: 'property_tracker', host: 'localhost'} )
  sql = "SELECT * FROM property_listings WHERE address = $1"
  values = [address]
  db.prepare("find_one", sql)
  address_find = db.exec_prepared("find_one", values)
  db.close
  return address_find.map { |result| PropertyListing.new(result)}
end

# def find(id)
#   for listing in @PropertyListing
#     return listing if listing.id = id
#   end
# end

def PropertyListing.all()
  db = PG.connect( {dbname: 'property_tracker', host: 'localhost'} )
  sql = "SELECT * FROM property_listings;"
  db.prepare("all", sql)
  listings = db.exec_prepared("all")
  db.close
  return listings.map { |listing_hash| PropertyListing.new( listing_hash )}
end

end
