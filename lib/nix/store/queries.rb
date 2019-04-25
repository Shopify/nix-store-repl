require('nix/store')

module Nix
  module Store
    module Queries
      def deriver
        # TODO(burke): unknown-deriver
        to_entry(query('--deriver', @path))
      end

      def outputs
        to_entries(query('--outputs', @path))
      end

      def requisites(include_outputs: false)
        args = include_outputs ? ['--include-outputs'] : []
        to_entries(query('--requisites', *args, @path))
      end

      def references
        to_entries(query('--references', @path))
      end

      def referrers
        to_entries(query('--referrers', @path))
      end

      def referrers_closure
        to_entries(query('--referrers-closure', @path))
      end

      def attr_binding(name)
        query('--binding', name, @path).chomp
      end

      def hash
        query('--hash', @path).chomp
      end

      def size
        query('--size', @path).chomp.to_i
      end

      def roots
        to_entries(query('--roots', @path))
      end

      private

      def query(*args)
        out, err, stat = Open3.capture3('nix-store', '--query', *args)
        raise(QueryFailed, err) unless stat.success?
        out
      end

      def to_entries(str)
        str.lines.map(&:chomp).map { |e| to_entry(e) }
      end

      def to_entry(line)
        Entry.for(line.sub(%r{(?:/nix/store/)?(.*)\n?}, '\1'))
      end
    end
  end
end
