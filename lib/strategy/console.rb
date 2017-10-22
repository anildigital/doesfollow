#
# Doesfollow console strategy
#
module Strategy
  class Console
    attr :output_streamer, true

    def doesfollow(doesfollow_status)
      if @output_streamer.nil?
        @output_streamer = $stdout
      end

      if doesfollow_status
        @output_streamer.puts("Yup")
      else
        @output_streamer.puts("Nope")
      end
    end

  end
end
