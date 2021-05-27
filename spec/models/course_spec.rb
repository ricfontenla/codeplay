require 'rails_helper'

describe Course do
  it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:code).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:price).with_message('não pode ficar em branco') }
  
  context 'registers instructor' do
    it 'code should be unique' do
      instructor = Instructor.create!(name: 'Fulano Fulano', 
                                      email: 'fulano@codeplay.com.br', 
                                      bio: 'Dev e instrutor na Code Play')
      Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                     code: 'RUBYBASIC', price: 10,
                     enrollment_deadline: '22/12/2033', 
                     instructor: instructor)
      should validate_uniqueness_of(:code).with_message('já está em uso')
    end
  end
end