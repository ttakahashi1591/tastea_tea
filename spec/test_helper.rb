def load_test_data 
  @ash = Customer.create!(first_name: "Ash", last_name: "Ketchum", email: "ash.ketchum@example.com", street_address: "Pallet Town", city: "Viridian", state: "Kanto", zip_code: "12345")
  @misty = Customer.create!(first_name: "Misty", last_name: "Waterflower", email: "misty.waterflower@example.com", street_address: "Cerulean City", city: "Cerulean", state: "Johto", zip_code: "67890")
  @brock = Customer.create!(first_name: "Brock", last_name: "Rock", email: "brock.rock@example.com", street_address: "Pewter City", city: "Pewter", state: "Sinnoh", zip_code: "13579")
  @may = Customer.create!(first_name: "May", last_name: "Maple", email: "may.maple@example.com", street_address: "Petalburg City", city: "Hoenn", state: "Unova", zip_code: "24680")
  @tsutomu = Customer.create!(first_name: "Tsutomu", last_name: "Takahashi", email: "afireinside@example.com", street_address: "Twinleaf Town", city: "Sinnoh", state: "Alola", zip_code: "43210")

  @bulbasaur_blend = Tea.create!(name: "Bulbasaur Blend", tea_type: "green", description: "A blend of green tea with hints of grass and citrus", temperature: 175, brew_time: 3)
  @charmander_chai = Tea.create!(name: "Charmander Chai", tea_type: "black", description: "Spicy chai with cinnamon, ginger, and a touch of fire", temperature: 200, brew_time: 5)
  @squirtle_serenity = Tea.create!(name: "Squirtle Serenity", tea_type: "white", description: "Subtle white tea with soothing notes of watermelon and mint", temperature: 185, brew_time: 4)
  @pikachu_peach = Tea.create!(name: "Pikachu Peach Paradise", tea_type: "white", description: "Peach-infused white tea for a fruity and electrifying experience", temperature: 185, brew_time: 4)
  @jigglypuff_jasmine = Tea.create!(name: "Jigglypuff Jasmine Dream", tea_type: "green", description: "Fragrant jasmine-infused green tea for a calming and soothing brew", temperature: 175, brew_time: 3)
  @eevee_earl_grey = Tea.create!(name: "Eevee Earl Grey Elegance", tea_type: "black", description: "Classic Earl Grey with bergamot, perfect for afternoon tea", temperature: 200, brew_time: 4)
  @vaporeon_vanilla = Tea.create!(name: "Vaporeon Vanilla Velvet", tea_type: "black", description: "Smooth black tea with creamy vanilla undertones", temperature: 200, brew_time: 4)
  @snorlax_spiced_chai = Tea.create!(name: "Snorlax Spiced Chai", tea_type: "black", description: "Rich and spiced chai blend to awaken your senses", temperature: 200, brew_time: 5)
  @mewtwo_matcha = Tea.create!(name: "Mewtwo Matcha Zen", tea_type: "matcha", description: "Premium matcha powder for a vibrant and energizing experience", temperature: 175, brew_time: 2)
  @gengar_ginger_lemon = Tea.create!(name: "Gengar Ginger Lemon Zest", tea_type: "herbal", description: "Invigorating herbal blend with ginger and zesty lemon", temperature: 212, brew_time: 5)

  @leafy = Subscription.create!(name: "Grass Type Pack", price: 15.99, frequency: "Bi-Weekly")
  @fiery = Subscription.create!(name: "Fire Type Pack", price: 18.49, frequency: "Monthly")
  @splashy = Subscription.create!(name: "Water Type Pack", price: 22.99, frequency: "Monthly")
  @sparky = Subscription.create!(name: "Electric Type Pack", price: 19.99, frequency: "Weekly")

  SubscriptionTea.create!(subscription: @leafy, tea: @bulbasaur_blend)
  SubscriptionTea.create!(subscription: @fiery, tea: @charmander_chai)
  SubscriptionTea.create!(subscription: @splashy, tea: @squirtle_serenity)
  SubscriptionTea.create!(subscription: @sparky, tea: @pikachu_peach)

  SubscriptionTea.create!(subscription: @fiery, tea: @jigglypuff_jasmine)
  SubscriptionTea.create!(subscription: @splashy, tea: @eevee_earl_grey)
  SubscriptionTea.create!(subscription: @fiery, tea: @vaporeon_vanilla)
  SubscriptionTea.create!(subscription: @sparky, tea: @snorlax_spiced_chai)

  SubscriptionTea.create!(subscription: @leafy, tea: @mewtwo_matcha)
  SubscriptionTea.create!(subscription: @fiery, tea: @gengar_ginger_lemon)

  CustomerSubscription.create!(customer: @ash, subscription: @leafy, status: "active")
  CustomerSubscription.create!(customer: @ash, subscription: @sparky, status: "cancelled")
  CustomerSubscription.create!(customer: @misty, subscription: @fiery, status: "cancelled")
  CustomerSubscription.create!(customer: @brock, subscription: @splashy, status: "active")
  CustomerSubscription.create!(customer: @may, subscription: @sparky, status: "paused")
  CustomerSubscription.create!(customer: @tsutomu, subscription: @sparky, status: "active" )
end