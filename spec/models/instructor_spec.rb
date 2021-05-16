describe Instructor do
  context 'Validation' do
    it 'attributes cannot be blank' do
      instructor = Instructor.new

      instructor.valid?

      expect(instructor.errors[:name]).to include('não pode ficar em branco')
      expect(instructor.errors[:email]).to include('não pode ficar em branco')
    end

    it 'email must be uniq' do
      Instructor.create!(name: 'Fulano', email: 'fulano@codeplay.com')

      instructor = Instructor.new(email: 'fulano@codeplay.com')

      instructor.valid?
      
      expect(instructor.errors[:email]).to include('já está em uso')
    end
  end
end