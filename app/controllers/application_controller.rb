class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
    get '/' do
      erb :index
    end

    get '/recipes/new' do
      erb :recipeform
    end 

    post '/recipes' do
      @recipe = Recipe.create(params)
      redirect "/recipes/#{@recipe.id}"
    end

    get '/recipes' do
      @recipes = Recipe.all
      erb :recipelist
    end
    
    get '/recipes/:id' do
      @recipe = Recipe.find(params[:id])
      erb :recipeshow
    end

    get '/recipes/:id/edit' do
      @recipe = Recipe.find(params[:id])
      erb :edit
    end

    patch '/recipes/:id' do
      recipe = Recipe.find(params[:id])
      new_params ={}
      new_params[:name] = params[:name]
      new_params[:ingredients] = params[:ingredients]
      new_params[:cook_time] = params[:cook_time]
      recipe.update(new_params)
  
      redirect "/recipes/#{recipe.id}"
    end

    delete '/recipes/:id' do
      recipe = Recipe.find(params[:id])
      recipe.destroy
      
      redirect "/recipes"
    end

end
