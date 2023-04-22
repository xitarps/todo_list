require 'rails_helper'

describe 'User' do
  before(:each) { Task.destroy_all }
  before(:each) { User.destroy_all }
  context 'update task' do
    it 'when valid title and description' do
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

      click_on 'Editar'

      fill_in 'Título',	with: 'comprar torrone'
      fill_in 'Descrição',	with: 'comprar muito torrone'

      click_on 'Salvar'
      # Assert
      expect(page).to have_content("Tarefa ##{Task.first.id}")
      expect(page).not_to have_content('comprar açucar')
      expect(page).to have_content('comprar torrone')
    end
    it 'fail when no description' do
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

      click_on 'Editar'

      fill_in 'Título',	with: 'comprar torrone'
      fill_in 'Descrição',	with: ''

      click_on 'Salvar'
      # Assert
      expect(page).not_to have_content("Tarefa ##{Task.first.id}")
      expect(page).to have_content('Editar Tarefa')
      expect(page).to have_content('Descrição não pode ficar em branco')
    end

    it 'fail when task belongs to another user' do
      # Arranje
      User.create(email: 'tester@tester.com', password: 'tester123').save
      User.create(email: 'tester2@tester.com', password: 'tester123').save
      Task.create(title: 'comprar açucar', description: 'comprar muito açucar', user_id: User.last.id)

      # Act
      visit '/'
      click_on 'Logar'
      fill_in 'Email',	with: 'tester@tester.com'
      fill_in 'Password',	with: 'tester123'
      click_on 'Log in'

      click_on 'Tarefas'

      # Assert
      expect(page).not_to have_content('Editar Tarefa')
    end
  end
end
