require 'rails_helper'

describe Code do
  context 'Associations' do
    it { should belong_to(:standard) }
    it { should have_and_belong_to_many(:lessons) }
  end
end