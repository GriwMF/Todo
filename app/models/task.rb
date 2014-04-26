class Task < ActiveRecord::Base
  belongs_to :project

  validates :title, :priority, presence: true

  def shift_priority
    project.tasks.where('priority > ?', priority).each do |task|
      task.priority -= 1
      task.save
    end
  end

  def drag_n_drop_switch(current_priority)
    tasks = if current_priority > priority
              priority_switch = -1
              project.tasks.where('priority between ? and ?', priority + 1, current_priority)
            else
              priority_switch = 1
              project.tasks.where('priority between ? and ?', current_priority, priority - 1)
            end

    tasks.each do |task|
      task.priority += priority_switch
      task.save
    end
  end
end
