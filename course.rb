class Course
  include DataMapper::Resource

  property :id, Serial
  property :code, String
  property :name, String
  
  has n, :tests
end

post '/courses' do
    course = Course.create(@json_body)
    
  if course
    status 201 # Created
    headers :location => uri("/courses/#{course.id}", true, true)
    body ({:id => course.id}).to_json  
  else
    status 400 # Bad Request
  end
end