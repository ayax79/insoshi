xml.instruct!
xml.xml do
  @songs.each do |song|
    xml.track do
      xml.path song.public_filename
      xml.title song.title
    end
  end
end