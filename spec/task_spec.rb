require 'spec_helper'

describe SporkTasks do
  describe 'install_tasks' do

    it "defines Rake tasks" do
      names = %w[spork:start spork:stop spork:restart]

      names.each { |name|
        expect { Rake.application[name] }.to raise_error(/Don't know how to build task/)
      }

      SporkTasks.new.install

      names.each { |name|
        expect { Rake.application[name] }.not_to raise_error
        expect(Rake.application[name]).to be_instance_of Rake::Task
      }
    end
  end
end
