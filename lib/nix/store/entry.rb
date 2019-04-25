require('nix/store')
require('open3')

module Nix
  module Store
    class Entry
      include(Nix::Store::Queries)

      class << self
        def for(basename)
          @instances ||= {}
          @instances[basename] ||= new(basename)
        end

        private(:new)
      end

      # TODO(burke): registry rather than generate objects
      def initialize(basename)
        @basename = basename
        @path     = File.join(Nix::Store::ROOT, basename)
      end

      def to_s
        @basename
      end

      def inspect
        %("#{@basename}")
      end

      def exist?
        File.exist?(@path)
      end
    end
  end
end
