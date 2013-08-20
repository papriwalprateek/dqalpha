class DropPgSearchAssociatedAgainstSupportFunctions < ActiveRecord::Migration
  def up
   say_with_time("Dropping support functions for pg_search :associated_against") do
      if ActiveRecord::Base.connection.send(:postgresql_version) < 80400
        execute <<-'SQL'
          DROP AGGREGATE array_agg(anyelement);

        SQL
      end
    end
  end

  def down
  end
end
