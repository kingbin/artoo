module Artoo
  # The Artoo::Master class is a registered supervisor class to keep track
  # of all the running robots
  class Master
    include Celluloid
		attr_reader :robots

    def initialize(bots)
      @robots = bots
    end

    def get_robot(name)
      robots.find {|r| r.name == name}
    end

    def get_robot_devices(name)
      get_robot(name).devices
    end

    def get_robot_device(name, device_id)
      get_robot_devices(name)[device_id.intern]
    end

    def get_robot_connections(name)
      get_robot(name).connections
    end

    def get_robot_connection(robot_id, connection_id)
      get_robot_connections(robot_id)[connection_id.intern]
    end

    def start_work
      robots.each {|r| r.async.work} unless Artoo::Robot.is_running?
    end
  end
end