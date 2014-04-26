require 'spec_helper'

describe Task do
  def create_project
    project= FactoryGirl.create :project
    3.times do |i|
      FactoryGirl.create :task, priority: i, project: project
    end
    project
  end

  context '#shift_priority' do
    it 'shifts priority higher than self' do
      project = create_project
      expect{project.tasks.first.shift_priority}.to change{ project.tasks.last.priority }.by(-1)
    end
  end

  context '#drag_n_drop_switch' do
    it 'shifts priorities between, when item been dragged' do
      project = create_project
      expect{project.tasks.first.drag_n_drop_switch(2)}.to change{ project.tasks.last.priority }.by(-1)
    end
  end
end