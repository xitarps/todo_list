require 'rails_helper'

describe 'User' do
  context 'view task' do
    before(:each) { Task.destroy_all }
    before(:each) { User.destroy_all }
    it 'when click on details with full description' do
      # Arranje
      User.create(email: 'tester@tester.com', password: 'tester123').save
      Task.create(title: 'comprar açucar', description: 'comprar muito açucar', user_id: User.last.id)

      # Act
      visit '/'
      click_on 'Login'
      fill_in 'Email',	with: 'tester@tester.com'
      fill_in 'Password',	with: 'tester123'
      click_on 'Log in'

      click_on 'Tarefas'

      click_on 'Detalhes'

      # Assert
      expect(page).to have_content("Tarefa ##{Task.first.id}")
      expect(page).to have_content('comprar açucar')
      expect(page).to have_content('comprar muito açucar')
    end
  end
end
