module ProjectDecorator

  def self.find_or_return(value)
    if value.is_a? Numeric
      Project.find value
    else
      value
    end
  end

  def has_hardware_id?(id)
    hardwares.collect(&:id).include? id
  end

  def hackday_organization
    hackday && hackday.hackday_organization
  end
end
