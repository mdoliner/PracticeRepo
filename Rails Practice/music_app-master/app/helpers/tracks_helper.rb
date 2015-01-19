module TracksHelper

  def ugly_lyrics(lyrics)
    lyric_arr = lyrics.split("\n")
    lyric_arr.map!{ |lyric| "♫ #{h(lyric)}" }
    <<-HTML.html_safe
      <pre>#{lyric_arr.join("\n")}</pre>
    HTML
  end
end
