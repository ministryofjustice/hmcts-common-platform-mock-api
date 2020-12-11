# frozen_string_literal: true

module Faker
  class CrackedIneffectiveTrial < Base
    CrackedIneffectiveTrialStruct = Struct.new(:code, :reason_type, :description)

    CRACKED_CODES = %w[A B C D E F G H I J K L].freeze
    VACATED_CODES = %w[A B C D E F G H I J K L M N O P Q Z].freeze
    INEFFECTIVE_CODES = %w[M1 M2 M3 N1 N2 N3 O1 O2 P Q1 Q2 Q3 R S1 S2 S3 S4 T U1 U2 V W1 W2 W3 W4 W5 X Y Z].freeze

    class << self
      def any
        struct_for(%i[cracked ineffective vacated].sample)
      end

      def cracked
        struct_for(:cracked)
      end

      def ineffective
        struct_for(:ineffective)
      end

      def vacated
        struct_for(:vacated)
      end

      private

      def struct_for(type)
        csv_line = fetch("cracked_ineffective_trial.#{type}.#{codes_for(type).sample}")
        arr = CSV.parse_line(csv_line, col_sep: ', ')
        CrackedIneffectiveTrialStruct.new(*arr)
      end

      def codes_for(type)
        const_get("#{type.upcase}_CODES")
      end
    end
  end
end
