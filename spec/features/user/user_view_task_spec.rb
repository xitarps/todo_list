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
      click_on 'Logar'
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
    it 'not be able to see tasks when not signed in' do
      # Arranje
      User.create(email: 'tester@tester.com', password: 'tester123').save
      Task.create(title: 'comprar açucar', description: 'comprar muito açucar', user_id: User.last.id)

      # Act
      visit '/'

      # Assert
      expect(page).not_to have_content('Tarefas')
      expect(page).to have_content('Logar')
    end

    it 'not be able to see tasks index when not signed in' do
      # Arranje
      User.create(email: 'tester@tester.com', password: 'tester123').save
      Task.create(title: 'comprar açucar', description: 'comprar muito açucar', user_id: User.last.id)

      # Act
      visit tasks_path

      # Assert
      expect(page).not_to have_content('Tarefas')
      expect(page).to have_content('Logar')
    end
  end
end
