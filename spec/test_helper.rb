def load_test_data 
  @ash = User.create!(first_name: "Ash", last_name: "Ketchum", email: "ash.ketchum@example.com", street_address: "Pallet Town", city: "Viridian", state: "Kanto", zip: "12345")
  @misty = User.create!(first_name: "Misty", last_name: "Waterflower", email: "misty.waterflower@example.com", street_address: "Cerulean City", city: "Cerulean", state: "Johto", zip: "67890")
  @brock = User.create!(first_name: "Brock", last_name: "Rock", email: "brock.rock@example.com", street_address: "Pewter City", city: "Pewter", state: "Sinnoh", zip: "13579")
  @may = User.create!(first_name: "May", last_name: "Maple", email: "may.maple@example.com", street_address: "Petalburg City", city: "Hoenn", state: "Unova", zip: "24680")
  @tsutomu = User.create!(first_name: "Tsutomu", last_name: "Takahashi", email: "afireinside@example.com", street_address: "Twinleaf Town", city: "Sinnoh", state: "Alola", zip: "43210")


  @bulbasaur_blend = Tea.create!(blend_name: "Bulbasaur Blend", type: "Green", description: "A blend of green tea with hints of grass and citrus", temperature: 175, brew_time: 3)
  @charmander_chai = Tea.create!(blend_name: "Charmander Chai", type: "Black", description: "Spicy chai with cinnamon, ginger, and a touch of fire", temperature: 200, brew_time: 5)
  @squirtle_serenity = Tea.create!(blend_name: "Squirtle Serenity", type: "White", description: "Subtle white tea with soothing notes of watermelon and mint", temperature: 185, brew_time: 4)
  @pikachu_peach = Tea.create!(blend_name: "Pikachu Peach Paradise", type: "White", description: "Peach-infused white tea for a fruity and electrifying experience", temperature: 185, brew_time: 4)
  @jigglypuff_jasmine = Tea.create!(blend_name: "Jigglypuff Jasmine Dream", type: "Green", description: "Fragrant jasmine-infused green tea for a calming and soothing brew", temperature: 175, brew_time: 3)
  @eevee_earl_grey = Tea.create!(blend_name: "Eevee Earl Grey Elegance", type: "Black", description: "Classic Earl Grey with bergamot, perfect for afternoon tea", temperature: 200, brew_time: 4)
  @vaporeon_vanilla = Tea.create!(blend_name: "Vaporeon Vanilla Velvet", type: "Black", description: "Smooth black tea with creamy vanilla undertones", temperature: 200, brew_time: 4)
  @snorlax_spiced_chai = Tea.create!(blend_name: "Snorlax Spiced Chai", type: "Black", description: "Rich and spiced chai blend to awaken your senses", temperature: 200, brew_time: 5)
  @mewtwo_matcha = Tea.create!(blend_name: "Mewtwo Matcha Zen", type: "Matcha", description: "Premium matcha powder for a vibrant and energizing experience", temperature: 175, brew_time: 2)
  @gengar_ginger_lemon = Tea.create!(blend_name: "Gengar Ginger Lemon Zest", type: "Herbal", description: "Invigorating herbal blend with ginger and zesty lemon", temperature: 212, brew_time: 5)


  @Leafy_subscription = Subscription.create!(name: "Grass Type Pack", price: 15.99, status: false, frequency: "Bi-Weekly")
  @flamey_subscription = Subscription.create!(name: "Fire Type Pack", price: 18.49, status: true, frequency: "Monthly")
  @splashy_subscription = Subscription.create!(name: "Water Type Pack", price: 22.99, status: false, frequency: "Monthly")
  @sparky_subscription = Subscription.create!(name: "Electric Type Pack", price: 19.99, status: true, frequency: "Weekly")


  SubscriptionTea.create!(subscription: @grassy_subscription, tea: @bulbasaur_blend)
  SubscriptionTea.create!(subscription: @fiery_subscription, tea: @charmander_chai)
  SubscriptionTea.create!(subscription: @watery_subscription, tea: @squirtle_serenity)
  SubscriptionTea.create!(subscription: @electric_subscription, tea: @pikachu_peach)

  SubscriptionTea.create!(subscription: @fiery_subscription, tea: @jigglypuff_jasmine)
  SubscriptionTea.create!(subscription: @watery_subscription, tea: @eevee_earl_grey)
  SubscriptionTea.create!(subscription: @flamey_subscription, tea: @vaporeon_vanilla)
  SubscriptionTea.create!(subscription: @sparky_subscription, tea: @snorlax_spiced_chai)

  SubscriptionTea.create!(subscription: @grassy_subscription, tea: @mewtwo_matcha)
  SubscriptionTea.create!(subscription: @flamey_subscription, tea: @gengar_ginger_lemon)

  CustomerSubscription.create!(customer: @ash, subscription: @grassy_subscription)
  CustomerSubscription.create!(customer: @misty, subscription: @fiery_subscription)
  CustomerSubscription.create!(customer: @brock, subscription: @watery_subscription)
  CustomerSubscription.create!(customer: @may, subscription: @electric_subscription)
  CustomerSubscription.create!(customer: @tsutomu, subscription: @sparky_subscription)
end