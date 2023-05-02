require 'rails_helper'

describe 'User' do
  let(:authenticated_user) {
    { "user": { "email": "tester@tester.com", "password": "tester123" } }
  }

  context 'view tasks' do
    before(:each) { Task.destroy_all }
    before(:each) { User.destroy_all }
    it 'when click on details with full description' do
      # Arranje
      User.create(email: 'tester@tester.com', password: 'tester123').save
      Task.create(title: 'comprar açucar', description: 'comprar muito açucar', user_id: User.last.id)
      Task.create(title: 'comprar leite', description: 'comprar muito leite', user_id: User.last.id)

      sugar_result = {:title=>"comprar açucar", :description=>"comprar muito açucar", :user=>"tester@tester.com"}
      milk_result ={:title=>"comprar leite", :description=>"comprar muito leite", :user=>"tester@tester.com"}

      # Act
      get '/api/v1/tasks', params: authenticated_user, xhr: true

      # Assert
      expect(response.body.like_json).to include(sugar_result)
      expect(response.body.like_json).to include(milk_result)
    end
  end

  context 'view task' do
    before(:each) { Task.destroy_all }
    before(:each) { User.destroy_all }
    it 'when click on details with full description' do
      # Arranje
      User.create(email: 'tester@tester.com', password: 'tester123').save
      task = Task.create(title: 'comprar açucar', description: 'comprar muito açucar', user_id: User.last.id)
      Task.create(title: 'comprar leite', description: 'comprar muito leite', user_id: User.last.id)

      sugar_result = {:title=>"comprar açucar", :description=>"comprar muito açucar"}
      milk_result ={:title=>"comprar leite", :description=>"comprar muito leite"}

      # Act
      get "/api/v1/tasks/#{task.id}", params: authenticated_user, xhr: true
      # result_set = JSON.parse(response.body.as_json, symbolize_names: true)

      # Assert
      expect(response.body.like_json).to include(sugar_result)
      expect(response.body.like_json).not_to include(milk_result)
    end
  end
end
