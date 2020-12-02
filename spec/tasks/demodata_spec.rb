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
    before { allow(FactoryBot).to receive(:create).and_call_original }

    let(:person_attrs) do
      {
        title: 'MR',
        firstName: 'Jammy',
        middleName: '',
        lastName: 'Dodger',
        dateOfBirth: '21-MAY-1987'.to_date,
        gender: 'MALE',
        nationalInsuranceNumber: 'JC123456A'
      }
    end

    it 'creates a specific person' do
      expect(FactoryBot).to receive(:create).with(:realistic_person, person_attrs)
      loader
    end

    it 'creates 2 cases' do
      expect { loader }.to change(ProsecutionCase, :count).by(2)
    end

    it 'creates 1 allocation_decision' do
      expect { loader }.to change(AllocationDecision, :count).by(1)
    end

    it 'creates 2 pleas' do
      expect { loader }.to change(Plea, :count).by(2)
    end

    it 'creates 2 defence counsels' do
      expect { loader }.to change(DefenceCounsel, :count).by(2)
    end

    context 'for case 1' do
      before { loader }

      let(:case1) { prosecution_cases_by_reference('TEST12345').first }

      it { expect(case1.prosecution_case_identifier.caseURN).to eql 'TEST12345' }

      it 'adds 3 hearings' do
        expect(case1.hearings.count).to be 3
      end

      it 'all hearings are "resulted"' do
        expect(case1.hearings.pluck(:resulted)).to all(be(true))
      end

      it 'adds 3 hearing days to each hearing' do
        expect(case1.hearings.map(&:hearing_days).map(&:size)).to eql([3, 3, 3])
      end

      it 'adds 10 hearing events to each hearing day' do
        expect(case1.hearings.flat_map(&:hearing_days).map(&:events).map(&:size)).to eql(Array.new(9, 10))
      end
    end
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
