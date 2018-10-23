class TasksController < ApplicationController

#Original code
  get '/tasks' do
    redirect_if_not_logged_in
    @user = current_user
    @lists = @user.lists
    erb :'tasks/show'
  end

  # get '/tasks' do
  #     if logged_in?
  #       @user = User.find(session[:user_id])
  #       #show list based on user_id
  #       @task = Task.where(user_id: current_user)
  #       # binding.pry
  #       erb :'tasks/show'
  #     else
  #     # redirect "/redirect_if_not_logged_in"
  #     #this will redirect user to another page if they try to access another list
  #     redirect "/failure"
  #   end
  # end


  # This will show the tasks
    post '/tasks' do
      if logged_in?
        @user = User.find_by(id: session[:user_id])
      if params[:task].empty?
        redirect "/tasks/new"
      else
        @user = User.find_by(id: session[:user_id])
        # this will create a new list if list is empty
      @task = Task.new
      @task.user_id = @user_id
      @task.save
      redirect '/tasks'
      end
    else
      redirect "/login"
    end
  end

# Creates a new task - Original code
  get '/tasks/new' do
    redirect_if_not_logged_in
    @user = current_user
    @lists = List.all
    erb :'/tasks/new'
  end

  # GET: /tasks/new
  # get "/tasks/new" do
  #   if logged_in?
  #     @user = User.find_by(id: session[:user_id])
  #     erb :"/tasks/new"
  #   else
  #     redirect "/failure"
  #   end
  # end

#Original code
  # post '/tasks/new' do
  #   Task.create(:name => params[:name], :list_id => params[:list_id])
  #   redirect '/tasks'
  #   end

  post '/tasks/new' do
    @user = current_user
    task = @user.tasks.create(:name => params[:name])
    task = task.tasks.create(:name => params[:tasks][:name])
    redirect '/tasks'
  end

# Creates a new task associated with the list id
  get '/tasks/new/:id' do
    redirect_if_not_logged_in
    @list = List.find_by_id(params[:id])
    erb :'/tasks/new_task'
  end

  post '/tasks/new/:id' do
    @list = List.find_by_id(params[:id])
    Task.create(:name => params[:name], :list_id => params[:id])
    redirect '/tasks'
  end

# Edits tasks - Original code
  get '/tasks/:id/edit' do
    @task = Task.find_by_id(params[:id])
    erb :'/tasks/edit'
  end

  # GET: /tasks/5
      # get "/tasks/:id/edit" do
      #   @user = User.find_by(id: session[:user_id])
      #   @task = Task.find(params[:id])
      #   if @task && @task.user == current_user
      #   erb :"/tasks/:id/edit"
      #   else
      #     redirect "/tasks"
      #   end
      # end

  patch '/tasks/:id' do
    @task = Task.find_by_id(params[:id])
    @task.name = params[:name]
    @task.save
    redirect '/tasks'
  end

# Deletes tasks
  get '/tasks/:id/delete' do
    @task = Task.find_by_id(params[:id])
    erb :'/tasks/delete'
  end

  delete '/tasks/:id' do
    @task = Task.find_by_id(params[:id])
    @task.destroy
    redirect '/tasks'
  end
end
