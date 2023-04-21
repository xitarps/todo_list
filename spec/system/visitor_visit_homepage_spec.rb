require 'rails_helper'

describe "Visitor visit homepage" do
  context "get /" do
    it 'should return Welcome' do
      visit '/'

      expect(page).to have_content('Welcome')
    end
  end
end
