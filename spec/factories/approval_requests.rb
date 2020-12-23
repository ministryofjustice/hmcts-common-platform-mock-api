# frozen_string_literal: true

FactoryBot.define do
  factory :approval_request do
    hearing
    userId { 'c9fa849a-4ca4-4dfe-b6f2-d08340899f10' }
    requestApprovalTime { '2020-12-23 14:35:36' }
    approvalType { 'CHANGE' }
  end
end
