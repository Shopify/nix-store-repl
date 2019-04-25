require('nix/store')

module Nix
  module Store
    class REPL
      autoload(:VERSION, 'nix/store/repl/version')

      INTRO = <<~MOTD
        This is a pry session. Make sure to use \x1b[1;34mls\x1b[0m and \x1b[1;34mcd\x1b[0m.
        Use \x1b[1;34mls -m\x1b[0m to find a useful method on this \x1b[1;33mNix::Store\x1b[0m object,
        then \x1b[1;34mcd\x1b[0m to another object.
      MOTD

      def self.start
        puts(INTRO)
        require('pry')
        Pry.start(
          Nix::Store,
          prompt: method(:prompt)
        )
      end

      def self.prompt(obj, nest_level, _)
        obj_color = case obj
        when Nix::Store::Entry
          obj.exist? ? "34" : "31"
        else
          "33"
        end
        "\x1b[1;#{obj_color}m#{obj}\x1b[38;5;241m/#{nest_level}\x1b[1;32m>\x1b[0m "
      end
    end
  end
end
