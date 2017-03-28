require 'sinatra'
require 'csv'
require 'pry'

set :bind, '0.0.0.0'  # bind to all interfaces

get "/" do
  redirect "/grocery-list"
end

get "/grocery-list" do
  @groceries = CSV.readlines("grocery_list.csv", headers: true)
  erb :index
end

post "/grocery-list" do
  if params[:grocery_name] == ""
    @error_message = "Please fill in grocery name."
    erb :index
  else
    CSV.open("grocery_list.csv", "a", headers: true) do |csv|
      csv << [params[:grocery_name]]
    end
    redirect "/grocery-list"
  end
end
