require 'spec_helper'

describe Task do
  context '#shift_priority' do
    it 'shifts priority higher than self' do
      project = FactoryGirl.create :project
      3.times do |i|
        FactoryGirl.create :task, priority: i, project: project
      end
      expect{project.tasks.first.shift_priority}.to change{ project.tasks.last.priority }.by(-1)
    end
  end
end