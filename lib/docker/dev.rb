require "docker/dev/version"
require "docker"

module Docker
  module Dev

    def self.set_env

      Docker::Container.all.find_all do |c|
        c.info['Names'].map { |n| n.split('/').last.upcase }.uniq.each do |service_name|
          c.info['Ports'].each do |port_info|
            if public_port = port_info['PublicPort']
              private_port = port_info['PrivatePort']
              port_type = port_info['Type']
              addr = "#{service_name}_PORT_#{private_port}_#{port_type.upcase}_ADDR"
              port = "#{service_name}_PORT_#{private_port}_#{port_type.upcase}_PORT"
              ENV[addr] = 'localhost'
              ENV[port] = "#{public_port}"
            end
          end
        end
      end

    # just log and do nothing if no docker available (like when we are inside a docker container)
    rescue Excon::Errors::SocketError => e
      Rails.logger.info e
    end

    class Railtie < ::Rails::Railtie
      config.before_initialize do
        Docker::Dev::set_env()
      end
    end

  end
end