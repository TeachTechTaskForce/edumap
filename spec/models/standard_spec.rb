require 'rails_helper'

describe Standard do
  context 'Associations' do
    it { should have_many(:codes) }
    it { should have_and_belong_to_many(:lessons) }
  end
end