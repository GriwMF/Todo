class Task < ActiveRecord::Base
  belongs_to :project

  def shift_priority
    project.tasks.where('priority > ?', priority).each do |task|
      task.priority -= 1
      task.save
    end
  end
end
