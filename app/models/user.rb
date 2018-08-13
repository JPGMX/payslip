class User < ApplicationRecord
  require 'csv'

  def self.import(file)
    data=CSV.read(file, { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
    users_data = data.map { |d| d.to_hash }

    users_data.each do |employee|
      p "Datos#{employee.keys}"
      employee[:gross_income]= calculate_gross_income(employee[:annual_salary])
      employee[:income_tax]= calculate_income_tax(employee[:annual_salary])
      employee[:net_income]=employee[:gross_income]-employee[:income_tax]
      employee[:super]= (employee[:gross_income] * ((employee[:super_rate].to_f)/ 100)).round
      User.create! employee
    end
  end

  private
  def self.calculate_gross_income(annual_salary)
    annual_salary/12 unless !annual_salary
  end

  def self.calculate_income_tax(annual_salary)
    calculation= case annual_salary
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
