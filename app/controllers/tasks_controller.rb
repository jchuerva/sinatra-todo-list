class TasksController < ApplicationController

  get '/tasks' do
    redirect_if_not_logged_in
    @tasks = Task.all
    erb :'tasks/index'
  end

  get '/tasks/new' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @lists = List.all
    erb :'tasks/new'
  end

  get '/tasks/:id/edit' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @task = Task.find(params[:id])
    @lists = List.all
    erb :'tasks/edit'
  end

  post '/tasks/:id' do
    redirect_if_not_logged_in
    @task = Task.find(params[:id])
    unless Task.valid_params?(params)
      redirect '/tasks/#{@task.id}/edit?error=invalid task'
    end
    @task.update(params.select{|k|k=="name"})
    redirect '/tasks/#{@task.id}'
  end

  get '/tasks/:id' do
    redirect_if_not_logged_in
    @task = Task.find(params[:id])
    erb :'tasks/show'
  end

  post "/tasks" do
    redirect_if_not_logged_in 
    unless Task.valid_params?(params)
      redirect "/tasks/new?error=invalid task"
    end
    Task.create(params)
    redirect "/tasks"
  end
 

end