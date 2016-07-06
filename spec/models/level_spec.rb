require 'rails_helper'

describe Level do
  context 'Associations' do
    it { should have_and_belong_to_many(:lessons) }
  end
end