class LocalAuthority < ActiveRecord::Base
  has_one :social_housing
  has_one :homelessness

  def number_of_homeless
    return nil if homelessness.type_1.nil? || homelessness.type_2.nil? || homelessness.type_3.nil?
    homelessness.type_1 + homelessness.type_2 + homelessness.type_3
  end

  def number_social_housing
    social_housing.household_total_rent
  end
  def percentage_social_housing
    number_social_housing*100.0/total_households
  end

  def percentage_homeless
    return if number_of_homeless.nil?
    number_of_homeless*100.0/total_households
  end

  def self.average_social_housing_household_percentage
    return 0 if has_data.count == 0
    sum = has_data.sum(&:percentage_social_housing)
    sum.to_f/has_data.count
  end
  def self.average_homeless_percentage
    return 0 if has_data.count == 0
    sum = has_data.sum(&:percentage_homeless)
    sum.to_f/has_data.count
  end

  def self.has_data
    @has_data ||= all.select{ |la| la.percentage_homeless.present? }
  end


end