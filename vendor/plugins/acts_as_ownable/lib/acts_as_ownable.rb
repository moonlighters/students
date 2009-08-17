module ActiveRecord
  module Acts
    module Ownable
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_ownable
          include ActiveRecord::Acts::Ownable::InstanceMethods
        end
      end

      module InstanceMethods
        # owner accessors
        def owner
          @owner ||
          ( owner_role.nil? ? nil : owner_role.users.first )
        end

        def owner=(user)
          @owner = user
        end

        def owner?(u); u == owner; end
        
        # This callback applies changing an owner by adding/removing roles
        def after_save 
          return unless @owner

          unless owner_role.nil?
            owner_role.users.each do |user|
              accepts_no_role!( :owner, user ) # unassign previous owners
            end
          end
            
          accepts_role!( :owner, @owner ) # assign new owner

          # clean up
          self.reload
          @owner = nil
        end
        private
          def owner_role
            accepted_roles.detect {|role| role.name == "owner"}
          end
      end
    end
  end
end
