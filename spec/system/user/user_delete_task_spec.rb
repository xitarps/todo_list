require 'rails_helper'

describe 'User' do
  before(:each) { Task.destroy_all }
  let(:task) { Task.create(title: 'comprar açucar', description: 'comprar muito açucar') }
  context 'delete task' do
    it 'when exists' do
      # Arranje
      task
      User.create(email: 'tester@tester.com', password: 'tester123')

      # Act
      visit '/'
      click_on 'Login'
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
