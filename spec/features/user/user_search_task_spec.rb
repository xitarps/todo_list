require 'rails_helper'

describe 'User' do
  before(:each) { Task.destroy_all }
  before(:each) { User.destroy_all }
  before(:each) { Category.destroy_all }
  context 'search task' do
    it 'should return correct task by name' do
      # Arranje
      Category.create(name: 'Turismo')
      Category.create(name: 'Educação')
      User.create(email: 'tester@tester.com', password: 'tester123').save
      Task.create(title: 'estudar ações', description: 'estudar mercado financeiro', user_id: User.last.id).save
      Task.create(title: 'comprar pão', description: 'comprar muito pão', user_id: User.last.id).save
      Task.create(title: 'estudar yotuber', description: 'virar youtuber', user_id: User.last.id).save

      # Act
      visit '/'
      click_on 'Logar'
      fill_in 'Email', with: 'tester@tester.com'
      fill_in 'Password',	with: 'tester123'
      click_on 'Log in'

      click_on 'Tarefas'

      fill_in 'Busca', with: 'estudar'
      click_on 'Buscar'

      # Assert
      # expect(page).to have_content('estudar ações')
      # expect(page).to have_content('estudar yotuber')
      expect(page).not_to have_content('comprar pão')
    end
  end
end
