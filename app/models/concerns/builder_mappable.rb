# frozen_string_literal: true

module BuilderMappable
  extend ActiveSupport::Concern

  included do
    private

    def array_builder(collection, options = {})
      return nil if collection.empty?

      collection.map { |item| item.to_builder(**options).attributes! }
    end

    def collection_ids(collection)
      return nil if collection.empty?

      collection.ids
    end
  end
end
