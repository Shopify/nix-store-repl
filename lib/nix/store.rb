module Nix
  module Store
    autoload(:REPL,    'nix/store/repl')
    autoload(:Entry,   'nix/store/entry')
    autoload(:Queries, 'nix/store/queries')

    Error       = Class.new(StandardError)
    QueryFailed = Class.new(Error)
    ROOT        = '/nix/store'

    def self.entries
      @entries ||= Dir.entries(ROOT)
        .reject { |e| e.start_with?('.') }
        .map    { |e| Entry.for(e) }
    end
  end
end
