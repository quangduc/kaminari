module Kaminari
  class Hooks
    def self.init
      ActiveSupport.on_load(:active_record) do
        require 'kaminari/models/active_record_extension'
        ::ActiveRecord::Base.send :include, Kaminari::ActiveRecordExtension
      end

      begin; require 'data_mapper'; rescue LoadError; end
      if defined? ::DataMapper
        require 'dm-aggregates'
        require 'kaminari/models/data_mapper_extension'
        ::DataMapper::Collection.send :include, Kaminari::DataMapperExtension::Collection
        ::DataMapper::Model.append_extensions Kaminari::DataMapperExtension::Model
        # ::DataMapper::Model.send :extend, Kaminari::DataMapperExtension::Model
      end

      require 'kaminari/models/array_extension'

      ActiveSupport.on_load(:action_view) do
        ::ActionView::Base.send :include, Kaminari::ActionViewExtension
      end
    end
  end
end
