module QueryTimeHelper
  extend ActiveSupport::Concern

  class Qt
    def initialize (name)
      #@queryTime = QueryTime.create(name: name)
      #@stages = {}
    end#initialize

    def start(name)
      #@stages[name] = {}
      #@stages[name][:start] = DateTime.now
    end#start

    def end(name)
      #@stages[name][:end] = DateTime.now
      #@queryTime.queryStages.create(name: @name, start: @stages[name][:start], end: @stages[name][:end])
    end#end

  end#qt
end#QueryTimeHelper
