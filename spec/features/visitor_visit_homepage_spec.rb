require 'rails_helper'

describe "Visitor visit homepage" do
  context "get /" do
    it 'should return Bem vindo(a)' do
      visit '/'

      expect(page).to have_content('Bem vindo(a)')
    end
  end
end
