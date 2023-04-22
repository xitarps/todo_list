require 'rails_helper'

describe 'User' do
  before(:each) { Task.destroy_all }
  before(:each) { User.destroy_all }
  context 'delete task' do
    it 'when exists' do
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

      click_on 'Apagar'

      # Assert
      expect(page).not_to have_content('comprar leite')
      expect(page).to have_content('Apagado com sucesso')
    end
  end
end
