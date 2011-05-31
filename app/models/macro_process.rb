class MacroProcess < ActiveRecord::Base

  has_many :critical_processes

  # Method user to return an array of 'authorized' critical processes available to to a access for a particular user for
  # a macro process
  def authorized_critical_processes(user)
    critical_processes = []

    self.critical_processes.uniq_by { |x| x.cp_secondary_id }.each do |x|
      cps = CriticalProcess.where(:cp_secondary_id => x.cp_secondary_id)
      if user.has_access_to(cps.first) || user.is_admin
        cps = cps.sort { |x, y| y.updated_at <=> x.updated_at }
      else
        cps = cps.select { |x| x.review.stage == 'approved' if x.review && x.review.stage }
        cps = cps.sort { |x, y| y.updated_at <=> x.updated_at }
      end
      critical_processes << cps.first unless cps.blank?
    end
    return critical_processes
  end

  # Method used to get a macro process's styling number, used to give the process a unique number to apply some color in CSS
  def get_macro_style_number
    if self.name == "Managing IT Like a Business"
      return 0
    elsif self.name == 'Managing IT For Business Value'
      return 1
    elsif self.name == 'Managing The IT Capability'
      return 2
    elsif self.name == 'Managing The IT Budget'
      return 3
    end
  end
end
