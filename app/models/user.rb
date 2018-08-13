class User < ApplicationRecord
  require 'csv'

  def self.import(file)
    data=CSV.read(file, { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
    raise Exception.new('Missing required file') unless data
    users_data = data.map { |d| d.to_hash }

    users_data.each do |employee|
      employee[:gross_income]= calculate_gross_income(employee[:annual_salary])
      employee[:income_tax]= calculate_income_tax(employee[:annual_salary])
      employee[:net_income]=employee[:gross_income]-employee[:income_tax]
      employee[:super]= (employee[:gross_income] * ((employee[:super_rate].to_f)/ 100)).round
      User.create! employee
    end
  end

  def self.export
    CSV.generate do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end

  private

  def self.validate_values(val)
    case val
    when String
      (val.delete("$,").to_f)
    when Float
      val
    else
      0
    end
  end
  
  def self.calculate_gross_income(annual_salary)
      validate_values(annual_salary)/12
  end

  def self.calculate_income_tax(annual_salary)
    calculation= case validate_values(annual_salary)
                 when 0..18000
                   nil
                 when 18201..37000
                   (((annual_salary-18200)*0.19)/12).round
                 when 37001..87000
                   ((3572 + ((annual_salary-37000)*0.325))/12).round
                 when 87001..180000
                   ((19822 + ((annual_salary-87000)*0.37))/12).round
                 else
                   ((54232 + ((annual_salary-18200)*0.19))/12).round
                 end

    calculation
  end
end
