class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipes = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    redirect to "/recipes/#{@recipes.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do #load edit form
    @recipe = Recipe.find_by_id(params[:id])
   erb :edit
  end
 
patch '/recipes/:id' do #edit action
  @recipe = Recipe.find_by_id(params[:id])
  @recipe.title = params[:title]
  @recipe.content = params[:content]
  @recipe.save
  redirect to "/recipes/#{@recipe.id}"
end

delete '/recipes/:id' do #delete action
  @recipe = Recipe.find_by_id(params[:id])
  @recipe.delete
  redirect to "/recipes"
end

end
