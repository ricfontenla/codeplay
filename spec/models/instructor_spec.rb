require 'rails_helper'

describe Instructor do
  it { should have_many(:courses) }
  it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:email).with_message('não pode ficar em branco') }
  it { should validate_uniqueness_of(:email).with_message('já está em uso') }
end