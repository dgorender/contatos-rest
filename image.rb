# Veja http://datamapper.org/getting-started.html
class Image
  include DataMapper::Resource

  property :id, Serial
  property :data, Text
end

# Obtém todos os images (ou filtra pelos parâmetros)
get '/images' do
  images = Image.all(params)
    
  status 200 # OK
  body images.to_json
end

# Obtém o image com o id fornecido
get '/images/:id' do
	image = Image.get(params[:id].to_i)
    
  if image
    status 200 # OK
    body image.to_json
  else
    status 404 # Not Found
	end
end

# Cria um image
post '/images' do
	image = Image.create(@json_body)
    
  if image
    status 201 # Created
    headers :location => uri("/images/#{image.id}", true, true)
    body ({:id => image.id}).to_json    
  else
    status 400 # Bad Request
  end
end

# Atualiza um image
put '/images/:id' do
	image = Image.get(params[:id].to_i)
    
  if image
    if image.update(@json_body)
      status 201 # Created
    else
      status 500 # Internal Server Error
    end
  else
    status 404 # Not Found
  end
end

# Apaga um image
delete '/images/:id' do
	image = Image.get(params[:id].to_i)
    
  if image
    if image.destroy
      status 200 # OK
    else
      status 500 # Internal Server Error
    end
  else
    status 404 # Not Found
	end
end