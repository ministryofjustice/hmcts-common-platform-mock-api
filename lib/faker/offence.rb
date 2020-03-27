# frozen_string_literal: true

module Faker
  class Offence < Base
    class << self
      def name
        fetch('offence.name')
      end

      def act
        fetch('offence.act')
      end

      def class
        fetch('offence.class')
      end
    end
  end
end
