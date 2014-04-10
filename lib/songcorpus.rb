Song.all.each do |s|
  arr = []
  s.video.each do |sv|
    sv = sv.gsub("watch?v=","embed/")
    arr<<sv
  end
  s.video = arr
  s.save!
end
