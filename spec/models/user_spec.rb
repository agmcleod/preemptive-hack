require 'rails_helper'

describe User do
  it 'user name should strip spaces' do
    user = User.new username: "A user name"
    user.save
    expect(user.username).to eq('ausername')
  end
end