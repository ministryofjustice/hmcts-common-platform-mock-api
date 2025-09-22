# frozen_string_literal: true

require "rake"

RSpec.describe "Demo data tasks", type: :rake do
  before(:all) { Rails.application.load_tasks if Rake::Task.tasks.empty? }

  around do |example|
    silence_output do
      example.run
    end
  end

  let(:loader) { Rake::Task["mock:demodata:load"].execute }
  let(:unloader) { Rake::Task["mock:demodata:unload"].execute }

  context "when loading demo data" do
    before { allow(FactoryBot).to receive(:create).and_call_original }

    let(:person_attrs) do
      {
        title: "MR",
        firstName: "Jammy",
        middleName: "",
        lastName: "Dodger",
        dateOfBirth: "21-MAY-1987".to_date,
        gender: "MALE",
        nationalInsuranceNumber: "JC123456A",
      }
    end

    it "creates a specific person" do
      expect(FactoryBot).to receive(:create).with(:realistic_person, person_attrs)
      loader
    end

    it "creates 4 cases" do
      expect { loader }.to change(ProsecutionCase, :count).by(4)
    end

    it "creates 1 allocation_decision" do
      expect { loader }.to change(AllocationDecision, :count).by(1)
    end

    it "creates 2 pleas" do
      expect { loader }.to change(Plea, :count).by(2)
    end

    it "creates 2 defence counsels" do
      expect { loader }.to change(DefenceCounsel, :count).by(2)
    end

    context "and for case 1" do
      before { loader }

      let(:case1) { prosecution_cases_by_reference("TEST12345").first }

      it "adds 4 defendants" do
        expect(case1.defendants.count).to be 4
      end

      it "adds 3 hearings" do
        expect(case1.hearings.count).to be 3
      end

      it 'all hearings are "resulted"' do
        expect(case1.hearings.pluck(:resulted)).to all(be(true))
      end

      it "adds 3 hearing days to each hearing" do
        expect(case1.hearings.map(&:hearing_days).map(&:size)).to eql([3, 3, 3])
      end

      it "adds unique sequential sittingDays to hearing days" do
        sitting_days = case1.hearings.flat_map { |h| h.hearing_days.map { |d| d.sittingDay.to_date } }
        expected_dates = (0..8).map { |i| "2019-10-23".to_date + i.days }
        expect(sitting_days).to match_array(expected_dates)
      end

      it "adds 10 hearing events to each hearing day" do
        expect(case1.hearings.flat_map(&:hearing_days).map(&:events).map(&:size)).to eql(Array.new(9, 10))
      end
    end

    context "and for case 2" do
      before { loader }

      let(:case2) { prosecution_cases_by_reference("TEST54321").first }

      it "adds 3 defendants" do
        expect(case2.defendants.count).to be 3
      end

      it "adds a cracked ineffective hearing" do
        expect(case2.hearings.map(&:cracked_ineffective_trial).compact.size).to be >= 1
      end
    end
  end

  describe "Demo data unload" do
    context "when demo data exists" do
      before { loader }

      it "destroys all the prosecution cases" do
        unloader

        expect(ProsecutionCase.count).to be 0
      end
    end

    context "when demo does not exist" do
      it "destroys 0 cases" do
        expect { unloader }.not_to change(ProsecutionCase, :count)
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
