# README

For this Challenge I've Updated the input to have "super_rate" instead of the percentage
Also I've assumed that the format will always be correct.

This was my first logical design for this problem:

```
require 'csv'

data=CSV.read("payslip.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})

hashed_data = data.map { |d| d.to_hash }

hashed_data.each do |employee|
  employee[:gross_income]=employee[:annual_salary]/12
  employee[:income_tax] = case employee[:annual_salary]
  when 0..18000
    nil
  when 18201..37000
    (((employee[:annual_salary]-18200)*0.19)/12).round
  when 37001..87000
    ((3572 + ((employee[:annual_salary]-37000)*0.325))/12).round
  when 87001..180000
    ((19822 + ((employee[:annual_salary]-87000)*0.37))/12).round
  else
    ((54232 + ((employee[:annual_salary]-18200)*0.19))/12).round
  end
  employee[:net_income]=employee[:gross_income]-employee[:income_tax]
  employee[:super]= (employee[:gross_income] * ((employee[:super_rate_].to_f)/ 100)).round
end

  CSV.open("payslip_output.csv", "w", headers: hashed_data.first.keys) do |csv|
    hashed_data.each do |h|
      csv << h.values
    end
  end
```

There is still validation to be done in unit tests, like validate if the Hash value exists
I didn't do Rspec for controllers, since I tought the main functionality was already tested
