require 'rails_helper'

describe 'User' do
  before(:each) { Task.destroy_all }
  context 'create task' do
    it 'when with title and description' do
      # Arranje
      User.create(email: 'tester@tester.com', password: 'tester123')

      # Act
      visit '/'
      click_on 'Login'
      fill_in 'Email',	with: 'tester@tester.com'
      fill_in 'Password',	with: 'tester123'
      click_on 'Log in'

      click_on 'Tarefas'

      click_on 'Nova Tarefa'

      fill_in 'Título',	with: 'comprar leite'
      fill_in 'Descrição',	with: 'comprar 3l de leite'
      click_on 'Salvar'

      # Assert
      expect(page).to have_content('Detalhes da tarefa')
      expect(page).to have_content('Tarefa #')
      expect(page).to have_content('comprar leite')
    end
    it 'fail when no title' do
      # Arranje
      User.create(email: 'tester@tester.com', password: 'tester123')

      # Act
      visit '/'
      click_on 'Login'
      fill_in 'Email',	with: 'tester@tester.com'
      fill_in 'Password',	with: 'tester123'
      click_on 'Log in'

      click_on 'Tarefas'

      click_on 'Nova Tarefa'

      fill_in 'Descrição',	with: 'comprar 3l de leite'
      click_on 'Salvar'

      # Assert
      expect(page).not_to have_content('Detalhes da tarefa')
      expect(page).not_to have_content('Tarefa #')
      expect(page).to have_content('comprar 3l de leite')
      expect(page).to have_content('Nova Tarefa')
      expect(page).to have_content('Título não pode ficar em branco')
    end
  end
end
