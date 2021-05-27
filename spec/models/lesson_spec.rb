require 'rails_helper'

describe Lesson do
  it { should belong_to(:course) }
  it { should validate_numericality_of(:duration).only_integer.is_greater_than(0) }
end