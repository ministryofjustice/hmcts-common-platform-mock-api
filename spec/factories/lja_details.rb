FactoryBot.define do
  factory :lja_detail do
    lja_code { "2577" }
    lja_name { "South West London Magistrates' Court" }
    welsh_lja_name { "Llys Ynadon De Orllewin Llundain" }

    factory :realistic_lja_detail do
      lja_code { "2577" }
      lja_name { "South West London Magistrates' Court" }
      welsh_lja_name { "Llys Ynadon De Orllewin Llundain" }
    end
  end
end
