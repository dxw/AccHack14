class LocalAuthority < ActiveRecord::Base
  has_one :social_housing
  has_one :homelessness
  has_one :social_housing_sale

  def number_of_homeless
    return nil if homelessness.type_1.nil? || homelessness.type_2.nil? || homelessness.type_3.nil?
    homelessness.type_1 + homelessness.type_2 + homelessness.type_3
  end
  def percentage_homeless
    return if number_of_homeless.nil?
    number_of_homeless*100.0/total_households
  end


  def number_social_housing
    social_housing.household_total_rent
  end
  def percentage_social_housing
    number_social_housing*100.0/total_households
  end


  def houses_sold
    social_housing_sale.sales
  end
  def percentage_houses_sold
    return if houses_sold.nil?
    houses_sold*100.0/number_social_housing
  end

  def need
    return nil if number_of_homeless.nil? || number_social_housing.nil?
    number_of_homeless + number_social_housing
  end
  def percentage_need
    return nil if need.nil?;
    number_social_housing*100.0/need
  end




  def self.average_social_housing_household_percentage
    return 0 if has_social_housing_data.count == 0
    sum = has_social_housing_data.sum(&:percentage_social_housing)
    sum.to_f/has_social_housing_data.count
  end
  def self.average_homeless_percentage
    return 0 if has_homeless_data.count == 0
    sum = has_homeless_data.sum(&:percentage_homeless)
    sum.to_f/has_homeless_data.count
  end
  def self.average_houses_sold
    return 0 if has_sold_data.count == 0
    sum = has_sold_data.sum(&:houses_sold)
    sum.to_f/has_sold_data.count
  end
  def self.average_need
    return 0 if has_need_data.count == 0
    sum = has_need_data.sum(&:percentage_need)
    sum.to_f/has_need_data.count
  end

  def self.has_homeless_data
    @has_homeless_data ||= all.select{ |la| la.percentage_homeless.present? }
  end
  def self.has_social_housing_data
    @has_social_housing_data ||= all.select{ |la| la.percentage_social_housing.present? }
  end
  def self.has_sold_data
    @has_sold_data ||= all.select{ |la| la.houses_sold.present? }
  end

  def self.has_need_data
    @has_need_data ||= all.select{ |la| la.need.present? }
  end
end