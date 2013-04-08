class Test
  include DataMapper::Resource

  property :id, Serial
  property :period, String
  property :unit, Integer
  property :grade, Float
  property :student, String
  
  has n, :images
  belongs_to :course, :required => false
end

post '/tests' do
    test = Test.create(@json_body)
    
  if test
    status 201 # Created
    headers :location => uri("/tests/#{test.id}", true, true)
    body ({:id => test.id}).to_json  
  else
    status 400 # Bad Request
  end
end