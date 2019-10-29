require("pry-byebug")
require_relative("./models/property_listing")

listing1 = PropertyListing.new(
  {
    'address' => '1 The Moon',
    'beds' => 30,
    'year_built' => 1997,
    'buy_let_status' => 'to let'
  } )

listing2 = PropertyListing.new( {
    'address' => '99 Saturn Way',
    'beds' => 1,
    'year_built' => 1903,
    'buy_let_status' => 'to buy'
  } )

listings = PropertyListing.all()

result = PropertyListing.find(5)

address_find = PropertyListing.find_by_address('99 Saturn Way')

binding.pry
nil
