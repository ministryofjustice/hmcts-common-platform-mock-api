# frozen_string_literal: true

require 'rake'

RSpec.describe 'Demo data tasks', type: :rake do
  before(:all) { Rails.application.load_tasks if Rake::Task.tasks.empty? }

  around do |example|
    silence_output do
      example.run
    end
  end

  let(:loader) { Rake::Task['mock:demodata:load'].execute }
  let(:unloader) { Rake::Task['mock:demodata:unload'].execute }

  context 'Demo data load' do
    it 'creates 2 cases' do
      expect { loader }.to change(ProsecutionCase, :count).by(2)
    end

    # rubocop:disable RSpec/ExampleLength
    it 'creates a specific person' do
      allow(FactoryBot).to receive(:create)
      expect(FactoryBot).to \
        receive(:create).with(
          :realistic_person,
          title: 'MR',
          firstName: 'Jammy',
          middleName: '',
          lastName: 'Dodger',
          dateOfBirth: '21-MAY-1987'.to_date,
          gender: 'MALE',
          nationalInsuranceNumber: 'JC123456A'
        )
      loader
    end
    # rubocop:enable RSpec/ExampleLength
  end

  context 'Demo data unload' do
    context 'when demo data exists' do
      before { loader }

      it 'destroys 2 cases' do
        expect { unloader }.to change(ProsecutionCase, :count).by(-2)
      end
    end

    context 'when demo does not exist' do
      it 'destroys 0 cases' do
        expect { unloader }.to change(ProsecutionCase, :count).by(0)
      end
    end
  end

  private

  def silence_output
    orig_stderr = $stderr
    orig_stdout = $stdout
    $stderr = StringIO.new
    $stdout = StringIO.new
    yield
  ensure
    $stderr = orig_stderr
    $stdout = orig_stdout
  end
end
