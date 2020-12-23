# frozen_string_literal: true

module Faker
  class Offence < Base
    class << self
      def name
        fetch("offence.name")
      end

      def act
        fetch("offence.act")
      end

      def class
        fetch("offence.class")
      end

      def mode_of_trial
        fetch("offence.mode_of_trial")
      end

      def mode_of_trial_reason
        fetch("offence.mode_of_trial_reason")
      end
    end
  end
end
