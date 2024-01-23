require "rails_helper" 

RSpec.describe SubscriptionSerializer do
  it "will return a hash of subscriptions for a requested customer" do
    load_test_data

    serializer = SubscriptionSerializer.new(@ash.subscriptions, params: {customer: @ash})

    expected_hash = {
      data: [
        {
          :id=>@leafy.id.to_s, 
          :type=>"subscription", 
          :attributes=>{
            :name=>"Grass Type Pack", 
            :price=>15.99, 
            :frequency=>"Bi-Weekly",
            :status=>"active"}
        },
        {
          :id=>@sparky.id.to_s, 
          :type=>"subscription", 
          :attributes=>{
            :name=>"Electric Type Pack", 
            :price=>19.99, 
            :frequency=>"Weekly",
            :status=>"cancelled"}
        }
      ]
    }

    expect(serializer.to_json).to eq(expected_hash.to_json)
  end
end