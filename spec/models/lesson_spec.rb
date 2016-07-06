require 'rails_helper'

describe Lesson do
  context 'Associations' do
    it { should belong_to(:curriculum) }
    it { should have_and_belong_to_many(:codes) }
    it { should have_and_belong_to_many(:levels) }
    it { should have_and_belong_to_many(:standards) }
  end
end