# frozen_string_literal: true

module BuilderMappable
  extend ActiveSupport::Concern

  included do
    private

    def array_builder(collection)
      return nil if collection.empty?

      collection.map { |item| item.to_builder.attributes! }
    end

    def split_prosecutor_case_references_builder
      return nil if split_prosecutor_case_references.empty?

      split_prosecutor_case_references.map(&:split)
    end

    def collection_ids(collection)
      return nil if collection.empty?

      collection.ids
    end
  end
end
