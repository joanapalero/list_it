class ListsController < ApplicationController

  get '/lists' do
      if logged_in?
        @user = User.find(session[:user_id])
        #show list based on user_id
        @list = List.where(user_id: current_user)
        # binding.pry
        erb :"index"
      else
      # redirect "/redirect_if_not_logged_in"
      #this will redirect user to another page if they try to access another list
      redirect "/failure"
    end
  end

  # This will show the Lists
    post '/lists' do
      if logged_in?
        @user = User.find_by(id: session[:user_id])
      if params[:list].empty?
        redirect "/lists/new"
      else
        @user = User.find_by(id: session[:user_id])
        # this will create a new list if list is empty
      @list = List.new
      @list.user_id = @user_id
      @list.save
      redirect '/tasks'
      end
    else
      redirect "/login"
    end
  end


  # #Original code
  # get '/lists/new' do
  #   redirect_if_not_logged_in
  #   erb :'/lists/new'
  # end

  # GET: /lists/new
  get "/lists/new" do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      erb :"/lists/new"
    else
      redirect "/failure"
    end
  end


  post '/lists/new' do
    @user = current_user
    list = @user.lists.create(:name => params[:name])
    task = list.tasks.create(:name => params[:tasks][:name])
    redirect '/tasks'
  end

#original code
  # get '/lists/:id/edit' do
  #   redirect_if_not_logged_in
  #   @list = List.find_by_id(params[:id])
  #   erb :'lists/edit'
  # end

  # GET: /lists/5
      get "/lists/:id/edit" do
        @user = User.find_by(id: session[:user_id])
        @list = List.find(params[:id])
        if @list && @list.user == current_user

        erb :"/lists/edit"
        else
          redirect "/tasks"
        end
      end

  patch '/lists/:id' do
    @list = List.find_by_id(params[:id])
    @list.name = params[:name]
    @list.save
    redirect '/tasks'
  end

  get '/lists/:id/delete' do
    @list = List.find_by_id(params[:id])
    erb :'lists/delete'
  end

  delete '/lists/:id' do
    @list = List.find_by_id(params[:id])
    @list.destroy
    redirect '/tasks'
  end

end
