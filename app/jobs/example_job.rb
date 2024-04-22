class ExampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    sleep 60
    puts 'My first job'
    custom
  end

  def custom
    puts 'Custom'
  end
end
