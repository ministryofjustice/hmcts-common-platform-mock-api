# frozen_string_literal: true

module BuilderMappable
  extend ActiveSupport::Concern

  included do
    private

    def array_builder(collection)
      return nil if collection.empty?

      collection.map { |item| item.to_builder.attributes! }
    end
  end
end
